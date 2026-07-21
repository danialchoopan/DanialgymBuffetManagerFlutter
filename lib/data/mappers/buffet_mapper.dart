import '../../../core/database/entities/buffet/product_entity.dart';
import '../../../core/database/entities/buffet/order_entity.dart';
import '../../../core/database/entities/buffet/order_item_entity.dart';
import '../../../core/database/entities/buffet/inventory_entity.dart';

class BuffetMapper {
  static ProductEntity toProductEntity(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      categoryId: map['category_id'],
      price: map['price'].toDouble(),
      costPrice: map['cost_price']?.toDouble(),
      sku: map['sku'],
      barcode: map['barcode'],
      imagePath: map['image_path'],
      unit: map['unit'] ?? 'piece',
      isAvailable: map['is_available'] ?? true,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      isActive: map['is_active'] ?? true,
    );
  }

  static Map<String, dynamic> toProductMap(ProductEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'description': entity.description,
      'category_id': entity.categoryId,
      'price': entity.price,
      'cost_price': entity.costPrice,
      'sku': entity.sku,
      'barcode': entity.barcode,
      'image_path': entity.imagePath,
      'unit': entity.unit,
      'is_available': entity.isAvailable,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt.toIso8601String(),
      'is_active': entity.isActive,
    };
  }

  static OrderEntity toOrderEntity(Map<String, dynamic> map) {
    return OrderEntity(
      id: map['id'],
      orderNumber: map['order_number'],
      memberId: map['member_id'],
      staffId: map['staff_id'],
      totalAmount: map['total_amount'].toDouble(),
      discountAmount: map['discount_amount']?.toDouble() ?? 0,
      taxAmount: map['tax_amount']?.toDouble() ?? 0,
      finalAmount: map['final_amount'].toDouble(),
      paymentMethod: map['payment_method'],
      status: map['status'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  static Map<String, dynamic> toOrderMap(OrderEntity entity) {
    return {
      'id': entity.id,
      'order_number': entity.orderNumber,
      'member_id': entity.memberId,
      'staff_id': entity.staffId,
      'total_amount': entity.totalAmount,
      'discount_amount': entity.discountAmount,
      'tax_amount': entity.taxAmount,
      'final_amount': entity.finalAmount,
      'payment_method': entity.paymentMethod,
      'status': entity.status,
      'notes': entity.notes,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt.toIso8601String(),
    };
  }

  static OrderItemEntity toOrderItemEntity(Map<String, dynamic> map) {
    return OrderItemEntity(
      id: map['id'],
      orderId: map['order_id'],
      productId: map['product_id'],
      productName: map['product_name'],
      quantity: map['quantity'],
      unitPrice: map['unit_price'].toDouble(),
      totalPrice: map['total_price'].toDouble(),
      notes: map['notes'],
    );
  }

  static Map<String, dynamic> toOrderItemMap(OrderItemEntity entity) {
    return {
      'id': entity.id,
      'order_id': entity.orderId,
      'product_id': entity.productId,
      'product_name': entity.productName,
      'quantity': entity.quantity,
      'unit_price': entity.unitPrice,
      'total_price': entity.totalPrice,
      'notes': entity.notes,
    };
  }

  static InventoryEntity toInventoryEntity(Map<String, dynamic> map) {
    return InventoryEntity(
      id: map['id'],
      productId: map['product_id'],
      productName: map['product_name'],
      currentStock: map['current_stock'],
      minimumStock: map['minimum_stock'],
      maximumStock: map['maximum_stock'],
      unit: map['unit'] ?? 'piece',
      lastRestockDate: map['last_restock_date'] != null
          ? DateTime.parse(map['last_restock_date'])
          : null,
      lastRestockQuantity: map['last_restock_quantity'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  static Map<String, dynamic> toInventoryMap(InventoryEntity entity) {
    return {
      'id': entity.id,
      'product_id': entity.productId,
      'product_name': entity.productName,
      'current_stock': entity.currentStock,
      'minimum_stock': entity.minimumStock,
      'maximum_stock': entity.maximumStock,
      'unit': entity.unit,
      'last_restock_date': entity.lastRestockDate?.toIso8601String(),
      'last_restock_quantity': entity.lastRestockQuantity,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt.toIso8601String(),
    };
  }
}