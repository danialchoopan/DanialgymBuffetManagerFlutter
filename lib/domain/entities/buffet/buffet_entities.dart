import 'package:equatable/equatable.dart';
import '../value_objects/enums.dart';
import '../value_objects/value_objects.dart';

class ProductEntity extends Equatable {
  final String id;
  final String productName;
  final String barcode;
  final String categoryId;
  final Money sellingPrice;
  final Money costPrice;
  final double currentStock;
  final double minStockLevel;
  final double maxStockLevel;
  final MeasurementUnit unit;
  final double? weightPerUnit;
  final String description;
  final bool isActive;
  final String? imagePath;
  final String? supplier;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastRestocked;

  const ProductEntity({
    required this.id,
    required this.productName,
    required this.barcode,
    required this.categoryId,
    required this.sellingPrice,
    required this.costPrice,
    required this.currentStock,
    required this.minStockLevel,
    required this.maxStockLevel,
    required this.unit,
    this.weightPerUnit,
    required this.description,
    this.isActive = true,
    this.imagePath,
    this.supplier,
    required this.createdAt,
    required this.updatedAt,
    this.lastRestocked,
  });

  // Business Methods
  Money get profitPerUnit => sellingPrice.subtract(costPrice);

  double get profitMargin {
    if (sellingPrice.amount <= 0) return 0;
    return ((sellingPrice.amount - costPrice.amount) / sellingPrice.amount) * 100;
  }

  StockStatus get stockStatus {
    if (currentStock <= 0) return StockStatus.outOfStock;
    if (currentStock <= minStockLevel) return StockStatus.lowStock;
    return StockStatus.inStock;
  }

  bool get needsRestocking => currentStock <= minStockLevel;

  bool get isOutOfStock => currentStock <= 0;

  bool isInStock(double quantity) => currentStock >= quantity;

  Money get stockValue => costPrice.multiply(currentStock);

  Money get potentialRevenue => sellingPrice.multiply(currentStock);

  double get stockPercentage {
    if (maxStockLevel <= 0) return 0;
    return (currentStock / maxStockLevel) * 100;
  }

  int get daysSinceLastRestock {
    if (lastRestocked == null) return -1;
    return DateTime.now().difference(lastRestocked!).inDays;
  }

  bool get needsImmediateRestock => currentStock <= minStockLevel * 0.5;

  ProductEntity reduceStock(double quantity) {
    if (!isInStock(quantity)) {
      throw InsufficientStockException(
        product: productName,
        available: currentStock,
        requested: quantity,
      );
    }
    return copyWith(
      currentStock: currentStock - quantity,
      updatedAt: DateTime.now(),
    );
  }

  ProductEntity addStock(double quantity) {
    final newStock = currentStock + quantity;
    if (newStock > maxStockLevel) {
      return copyWith(
        currentStock: maxStockLevel,
        lastRestocked: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
    return copyWith(
      currentStock: newStock,
      lastRestocked: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  ProductEntity adjustStock(double newQuantity, String reason) {
    return copyWith(
      currentStock: newQuantity,
      updatedAt: DateTime.now(),
    );
  }

  ProductEntity copyWith({
    String? id,
    String? productName,
    String? barcode,
    String? categoryId,
    Money? sellingPrice,
    Money? costPrice,
    double? currentStock,
    double? minStockLevel,
    double? maxStockLevel,
    MeasurementUnit? unit,
    double? weightPerUnit,
    String? description,
    bool? isActive,
    String? imagePath,
    String? supplier,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastRestocked,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      barcode: barcode ?? this.barcode,
      categoryId: categoryId ?? this.categoryId,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      costPrice: costPrice ?? this.costPrice,
      currentStock: currentStock ?? this.currentStock,
      minStockLevel: minStockLevel ?? this.minStockLevel,
      maxStockLevel: maxStockLevel ?? this.maxStockLevel,
      unit: unit ?? this.unit,
      weightPerUnit: weightPerUnit ?? this.weightPerUnit,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      imagePath: imagePath ?? this.imagePath,
      supplier: supplier ?? this.supplier,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastRestocked: lastRestocked ?? this.lastRestocked,
    );
  }

  @override
  List<Object?> get props => [
    id, productName, barcode, categoryId, sellingPrice, costPrice,
    currentStock, minStockLevel, maxStockLevel, unit, weightPerUnit,
    description, isActive, imagePath, supplier, createdAt, updatedAt,
    lastRestocked,
  ];
}

class OrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final String? memberId;
  final String? customerName;
  final String? tableNumber;
  final List<OrderItemEntity> items;
  final Money subtotal;
  final Money discountAmount;
  final Money taxAmount;
  final Money totalPrice;
  final OrderStatus orderStatus;
  final PaymentStatus paymentStatus;
  final PaymentMethod? paymentMethod;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;

  const OrderEntity({
    required this.id,
    required this.orderNumber,
    this.memberId,
    this.customerName,
    this.tableNumber,
    this.items = const [],
    required this.subtotal,
    this.discountAmount = const Money.zero(),
    required this.taxAmount,
    required this.totalPrice,
    this.orderStatus = OrderStatus.pending,
    this.paymentStatus = PaymentStatus.pending,
    this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
  });

  // Business Methods
  Money calculateTotal() {
    final itemsTotal = items.fold<Money>(
      const Money.zero(),
      (sum, item) => sum.add(item.totalPrice),
    );
    return itemsTotal.subtract(discountAmount).add(taxAmount);
  }

  bool get isFullyPaid => paymentStatus == PaymentStatus.paid;

  bool get isPartiallyPaid => paymentStatus == PaymentStatus.partial;

  Money get remainingAmount {
    if (isFullyPaid) return const Money.zero();
    return totalPrice.subtract(_calculateAmountPaid());
  }

  Money _calculateAmountPaid() {
    // This would typically be calculated from payment records
    if (paymentStatus == PaymentStatus.paid) return totalPrice;
    if (paymentStatus == PaymentStatus.partial) {
      return totalPrice.multiply(0.5); // Simplified
    }
    return const Money.zero();
  }

  Duration get orderDuration {
    if (completedAt == null) return Duration.zero;
    return completedAt!.difference(createdAt);
  }

  int get totalItems => items.fold<int>(0, (sum, item) => sum + item.quantity);

  bool get canBeCancelled =>
      orderStatus == OrderStatus.pending ||
      orderStatus == OrderStatus.preparing;

  bool get canBeModified =>
      orderStatus == OrderStatus.pending;

  OrderEntity applyDiscount(double percentage) {
    final discount = subtotal.multiply(percentage / 100);
    return copyWith(
      discountAmount: discount,
      totalPrice: subtotal.subtract(discount).add(taxAmount),
    );
  }

  OrderEntity applyFixedDiscount(Money discount) {
    return copyWith(
      discountAmount: discount,
      totalPrice: subtotal.subtract(discount).add(taxAmount),
    );
  }

  OrderEntity updateStatus(OrderStatus newStatus) {
    final now = DateTime.now();
    return copyWith(
      orderStatus: newStatus,
      completedAt: newStatus == OrderStatus.completed ? now : completedAt,
      updatedAt: now,
    );
  }

  OrderEntity markAsPaid(PaymentMethod method) {
    return copyWith(
      paymentStatus: PaymentStatus.paid,
      paymentMethod: method,
      updatedAt: DateTime.now(),
    );
  }

  OrderEntity markAsPartialPayment(Money amount) {
    final newTotal = remainingAmount.subtract(amount);
    return copyWith(
      paymentStatus: newTotal.amount <= 0
          ? PaymentStatus.paid
          : PaymentStatus.partial,
      updatedAt: DateTime.now(),
    );
  }

  OrderEntity cancel() {
    return copyWith(
      orderStatus: OrderStatus.cancelled,
      updatedAt: DateTime.now(),
    );
  }

  OrderEntity copyWith({
    String? id,
    String? orderNumber,
    String? memberId,
    String? customerName,
    String? tableNumber,
    List<OrderItemEntity>? items,
    Money? subtotal,
    Money? discountAmount,
    Money? taxAmount,
    Money? totalPrice,
    OrderStatus? orderStatus,
    PaymentStatus? paymentStatus,
    PaymentMethod? paymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      memberId: memberId ?? this.memberId,
      customerName: customerName ?? this.customerName,
      tableNumber: tableNumber ?? this.tableNumber,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      discountAmount: discountAmount ?? this.discountAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      totalPrice: totalPrice ?? this.totalPrice,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [
    id, orderNumber, memberId, customerName, tableNumber, items,
    subtotal, discountAmount, taxAmount, totalPrice, orderStatus,
    paymentStatus, paymentMethod, createdAt, updatedAt, completedAt,
  ];
}

class OrderItemEntity extends Equatable {
  final String id;
  final String orderId;
  final ProductEntity product;
  final int quantity;
  final Money unitPrice;
  final Money totalPrice;
  final String? notes;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.notes,
  });

  // Business Methods
  Money get discount => unitPrice.multiply(quantity).subtract(totalPrice);

  bool get hasDiscount => discount.amount > 0;

  double get discountPercentage {
    final originalPrice = unitPrice.multiply(quantity);
    if (originalPrice.amount <= 0) return 0;
    return (discount.amount / originalPrice.amount) * 100;
  }

  OrderItemEntity applyDiscount(double percentage) {
    final originalPrice = unitPrice.multiply(quantity);
    final discountAmount = originalPrice.multiply(percentage / 100);
    return copyWith(
      totalPrice: originalPrice.subtract(discountAmount),
    );
  }

  OrderItemEntity updateQuantity(int newQuantity) {
    return copyWith(
      quantity: newQuantity,
      totalPrice: unitPrice.multiply(newQuantity),
    );
  }

  OrderItemEntity copyWith({
    String? id,
    String? orderId,
    ProductEntity? product,
    int? quantity,
    Money? unitPrice,
    Money? totalPrice,
    String? notes,
  }) {
    return OrderItemEntity(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
    id, orderId, product, quantity, unitPrice, totalPrice, notes,
  ];
}

class InventoryTransactionEntity extends Equatable {
  final String id;
  final String productId;
  final TransactionType transactionType;
  final double quantity;
  final double previousQuantity;
  final double newQuantity;
  final InventoryReason reason;
  final String? referenceId;
  final String? notes;
  final DateTime transactionDate;
  final String? performedBy;

  const InventoryTransactionEntity({
    required this.id,
    required this.productId,
    required this.transactionType,
    required this.quantity,
    required this.previousQuantity,
    required this.newQuantity,
    required this.reason,
    this.referenceId,
    this.notes,
    required this.transactionDate,
    this.performedBy,
  });

  // Business Methods
  double get netChange => newQuantity - previousQuantity;

  bool get isAddition => transactionType == TransactionType.addition;

  bool get isReduction => transactionType == TransactionType.reduction;

  bool get isAdjustment => transactionType == TransactionType.adjustment;

  bool get isValidQuantity => newQuantity >= 0;

  bool validateTransaction() {
    if (!isValidQuantity) return false;
    if (isReduction && quantity > previousQuantity) return false;
    return true;
  }

  InventoryTransactionEntity copyWith({
    String? id,
    String? productId,
    TransactionType? transactionType,
    double? quantity,
    double? previousQuantity,
    double? newQuantity,
    InventoryReason? reason,
    String? referenceId,
    String? notes,
    DateTime? transactionDate,
    String? performedBy,
  }) {
    return InventoryTransactionEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      transactionType: transactionType ?? this.transactionType,
      quantity: quantity ?? this.quantity,
      previousQuantity: previousQuantity ?? this.previousQuantity,
      newQuantity: newQuantity ?? this.newQuantity,
      reason: reason ?? this.reason,
      referenceId: referenceId ?? this.referenceId,
      notes: notes ?? this.notes,
      transactionDate: transactionDate ?? this.transactionDate,
      performedBy: performedBy ?? this.performedBy,
    );
  }

  @override
  List<Object?> get props => [
    id, productId, transactionType, quantity, previousQuantity,
    newQuantity, reason, referenceId, notes, transactionDate, performedBy,
  ];
}

// Enums for buffet entities
enum OrderStatus { pending, preparing, ready, completed, cancelled }
enum TransactionType { addition, reduction, adjustment }
enum InventoryReason { sale, restock, return, loss, adjustment, damage }
enum StockStatus { inStock, lowStock, outOfStock }

// Exceptions
class InsufficientStockException implements Exception {
  final String product;
  final double available;
  final double requested;

  InsufficientStockException({
    required this.product,
    required this.available,
    required this.requested,
  });

  @override
  String toString() =>
      'Insufficient stock for $product: available $available, requested $requested';
}