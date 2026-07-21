import 'package:equatable/equatable.dart';
import '../value_objects/enums.dart';
import '../value_objects/value_objects.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String transactionNumber;
  final TransactionCategory transactionType;
  final String category;
  final Money amount;
  final Money taxAmount;
  final Money totalAmount;
  final String? description;
  final String? referenceId;
  final TransactionReferenceType? referenceType;
  final bool isVerified;
  final DateTime? verificationDate;
  final DateTime transactionDate;
  final DateTime createdAt;
  final String? recordedBy;

  const TransactionEntity({
    required this.id,
    required this.transactionNumber,
    required this.transactionType,
    required this.category,
    required this.amount,
    this.taxAmount = const Money.zero(),
    required this.totalAmount,
    this.description,
    this.referenceId,
    this.referenceType,
    this.isVerified = false,
    this.verificationDate,
    required this.transactionDate,
    required this.createdAt,
    this.recordedBy,
  });

  // Business Methods
  bool get isIncome => transactionType == TransactionCategory.income;
  
  bool get isExpense => transactionType == TransactionCategory.expense;

  Money get netAmount => amount;

  String get categoryString => category;

  bool get needsVerification => !isVerified && totalAmount.amount > 1000;

  TransactionEntity verify(String verifierId) {
    return copyWith(
      isVerified: true,
      verificationDate: DateTime.now(),
    );
  }

  TransactionEntity copyWith({
    String? id,
    String? transactionNumber,
    TransactionCategory? transactionType,
    String? category,
    Money? amount,
    Money? taxAmount,
    Money? totalAmount,
    String? description,
    String? referenceId,
    TransactionReferenceType? referenceType,
    bool? isVerified,
    DateTime? verificationDate,
    DateTime? transactionDate,
    DateTime? createdAt,
    String? recordedBy,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      transactionNumber: transactionNumber ?? this.transactionNumber,
      transactionType: transactionType ?? this.transactionType,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      taxAmount: taxAmount ?? this.taxAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      description: description ?? this.description,
      referenceId: referenceId ?? this.referenceId,
      referenceType: referenceType ?? this.referenceType,
      isVerified: isVerified ?? this.isVerified,
      verificationDate: verificationDate ?? this.verificationDate,
      transactionDate: transactionDate ?? this.transactionDate,
      createdAt: createdAt ?? this.createdAt,
      recordedBy: recordedBy ?? this.recordedBy,
    );
  }

  @override
  List<Object?> get props => [
    id, transactionNumber, transactionType, category, amount,
    taxAmount, totalAmount, description, referenceId, referenceType,
    isVerified, verificationDate, transactionDate, createdAt, recordedBy,
  ];
}

class InvoiceEntity extends Equatable {
  final String id;
  final String invoiceNumber;
  final String? memberId;
  final String customerName;
  final String? customerPhone;
  final List<InvoiceItemEntity> items;
  final Money subtotal;
  final Money discount;
  final Money tax;
  final Money total;
  final InvoiceStatus invoiceStatus;
  final DateTime issuedDate;
  final DateTime dueDate;
  final DateTime? paidDate;
  final List<InstallmentPlanEntity> installmentPlan;

  const InvoiceEntity({
    required this.id,
    required this.invoiceNumber,
    this.memberId,
    required this.customerName,
    this.customerPhone,
    this.items = const [],
    required this.subtotal,
    this.discount = const Money.zero(),
    required this.tax,
    required this.total,
    this.invoiceStatus = InvoiceStatus.draft,
    required this.issuedDate,
    required this.dueDate,
    this.paidDate,
    this.installmentPlan = const [],
  });

  // Business Methods
  Money calculateTotal() {
    return subtotal.subtract(discount).add(tax);
  }

  Money get balance => total.subtract(_calculateAmountPaid());

  Money _calculateAmountPaid() {
    final paidInstallments = installmentPlan
        .where((i) => i.isPaid)
        .fold<Money>(
          const Money.zero(),
          (sum, i) => sum.add(i.amount),
        );
    return paidInstallments;
  }

  bool get isOverdue =>
      invoiceStatus != InvoiceStatus.paid &&
      DateTime.now().isAfter(dueDate);

  InvoicePaymentStatus get paymentStatus {
    if (invoiceStatus == InvoiceStatus.paid) return InvoicePaymentStatus.paid;
    if (isOverdue) return InvoicePaymentStatus.overdue;
    if (_calculateAmountPaid().amount > 0) return InvoicePaymentStatus.partial;
    return InvoicePaymentStatus.unpaid;
  }

  InstallmentPlanEntity? get nextInstallment {
    if (installmentPlan.isEmpty) return null;
    try {
      return installmentPlan.firstWhere((i) => !i.isPaid);
    } catch (_) {
      return null;
    }
  }

  int get daysUntilDue {
    final diff = dueDate.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  bool get canBeCancelled => invoiceStatus == InvoiceStatus.draft;

  bool get canBeIssued => invoiceStatus == InvoiceStatus.draft;

  InvoiceEntity issue() {
    return copyWith(
      invoiceStatus: InvoiceStatus.issued,
    );
  }

  InvoiceEntity markAsPaid() {
    return copyWith(
      invoiceStatus: InvoiceStatus.paid,
      paidDate: DateTime.now(),
    );
  }

  InvoiceEntity cancel() {
    return copyWith(
      invoiceStatus: InvoiceStatus.cancelled,
    );
  }

  InvoiceEntity applyDiscount(double percentage) {
    final discountAmount = subtotal.multiply(percentage / 100);
    return copyWith(
      discount: discountAmount,
      total: subtotal.subtract(discountAmount).add(tax),
    );
  }

  InvoiceEntity copyWith({
    String? id,
    String? invoiceNumber,
    String? memberId,
    String? customerName,
    String? customerPhone,
    List<InvoiceItemEntity>? items,
    Money? subtotal,
    Money? discount,
    Money? tax,
    Money? total,
    InvoiceStatus? invoiceStatus,
    DateTime? issuedDate,
    DateTime? dueDate,
    DateTime? paidDate,
    List<InstallmentPlanEntity>? installmentPlan,
  }) {
    return InvoiceEntity(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      memberId: memberId ?? this.memberId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      invoiceStatus: invoiceStatus ?? this.invoiceStatus,
      issuedDate: issuedDate ?? this.issuedDate,
      dueDate: dueDate ?? this.dueDate,
      paidDate: paidDate ?? this.paidDate,
      installmentPlan: installmentPlan ?? this.installmentPlan,
    );
  }

  @override
  List<Object?> get props => [
    id, invoiceNumber, memberId, customerName, customerPhone,
    items, subtotal, discount, tax, total, invoiceStatus,
    issuedDate, dueDate, paidDate, installmentPlan,
  ];
}

class InvoiceItemEntity extends Equatable {
  final String id;
  final String invoiceId;
  final String description;
  final int quantity;
  final Money unitPrice;
  final Money total;

  const InvoiceItemEntity({
    required this.id,
    required this.invoiceId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });

  // Business Methods
  Money get discount => unitPrice.multiply(quantity).subtract(total);

  bool get hasDiscount => discount.amount > 0;

  InvoiceItemEntity applyDiscount(double percentage) {
    final originalPrice = unitPrice.multiply(quantity);
    final discountAmount = originalPrice.multiply(percentage / 100);
    return copyWith(
      total: originalPrice.subtract(discountAmount),
    );
  }

  InvoiceItemEntity copyWith({
    String? id,
    String? invoiceId,
    String? description,
    int? quantity,
    Money? unitPrice,
    Money? total,
  }) {
    return InvoiceItemEntity(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [id, invoiceId, description, quantity, unitPrice, total];
}

class InstallmentPlanEntity extends Equatable {
  final String id;
  final String invoiceId;
  final int installmentNumber;
  final Money amount;
  final DateTime dueDate;
  final DateTime? paidDate;
  final bool isPaid;

  const InstallmentPlanEntity({
    required this.id,
    required this.invoiceId,
    required this.installmentNumber,
    required this.amount,
    required this.dueDate,
    this.paidDate,
    this.isPaid = false,
  });

  // Business Methods
  bool get isOverdue => !isPaid && DateTime.now().isAfter(dueDate);

  int get daysUntilDue {
    final diff = dueDate.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  InstallmentPlanEntity markAsPaid() {
    return copyWith(
      isPaid: true,
      paidDate: DateTime.now(),
    );
  }

  InstallmentPlanEntity copyWith({
    String? id,
    String? invoiceId,
    int? installmentNumber,
    Money? amount,
    DateTime? dueDate,
    DateTime? paidDate,
    bool? isPaid,
  }) {
    return InstallmentPlanEntity(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      installmentNumber: installmentNumber ?? this.installmentNumber,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      paidDate: paidDate ?? this.paidDate,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  @override
  List<Object?> get props => [
    id, invoiceId, installmentNumber, amount, dueDate, paidDate, isPaid,
  ];
}

class MemberFinancialSummaryEntity extends Equatable {
  final String memberId;
  final Money totalPaid;
  final Money totalDue;
  final Money outstandingBalance;
  final DateTime? lastPaymentDate;
  final Money membershipCost;
  final DateTime? nextPaymentDate;
  final Money averageMonthlySpend;
  final double paymentReliability; // 0-100

  const MemberFinancialSummaryEntity({
    required this.memberId,
    required this.totalPaid,
    required this.totalDue,
    required this.outstandingBalance,
    this.lastPaymentDate,
    required this.membershipCost,
    this.nextPaymentDate,
    required this.averageMonthlySpend,
    required this.paymentReliability,
  });

  // Business Methods
  Money get balance => outstandingBalance;

  bool get hasOverduePayments => totalDue.amount > 0;

  bool get isFullyPaid => outstandingBalance.amount <= 0;

  FinancialStatus get financialStatus {
    if (paymentReliability >= 90) return FinancialStatus.good;
    if (paymentReliability >= 70) return FinancialStatus.warning;
    return FinancialStatus.bad;
  }

  int get daysUntilNextPayment {
    if (nextPaymentDate == null) return -1;
    return nextPaymentDate!.difference(DateTime.now()).inDays;
  }

  bool get needsPaymentReminder => daysUntilNextPayment <= 7 && daysUntilNextPayment >= 0;

  MemberFinancialSummaryEntity copyWith({
    String? memberId,
    Money? totalPaid,
    Money? totalDue,
    Money? outstandingBalance,
    DateTime? lastPaymentDate,
    Money? membershipCost,
    DateTime? nextPaymentDate,
    Money? averageMonthlySpend,
    double? paymentReliability,
  }) {
    return MemberFinancialSummaryEntity(
      memberId: memberId ?? this.memberId,
      totalPaid: totalPaid ?? this.totalPaid,
      totalDue: totalDue ?? this.totalDue,
      outstandingBalance: outstandingBalance ?? this.outstandingBalance,
      lastPaymentDate: lastPaymentDate ?? this.lastPaymentDate,
      membershipCost: membershipCost ?? this.membershipCost,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      averageMonthlySpend: averageMonthlySpend ?? this.averageMonthlySpend,
      paymentReliability: paymentReliability ?? this.paymentReliability,
    );
  }

  @override
  List<Object?> get props => [
    memberId, totalPaid, totalDue, outstandingBalance, lastPaymentDate,
    membershipCost, nextPaymentDate, averageMonthlySpend, paymentReliability,
  ];
}

// Enums for accounting entities
enum TransactionCategory { income, expense }
enum TransactionReferenceType { membership, product, service, order, invoice }
enum InvoiceStatus { draft, issued, paid, cancelled, overdue }
enum InvoicePaymentStatus { unpaid, partial, paid, overdue }
enum FinancialStatus { good, warning, bad }