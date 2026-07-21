import 'package:equatable/equatable.dart';
import '../value_objects/enums.dart';
import '../value_objects/value_objects.dart';

class MemberPaymentEntity extends Equatable {
  final String id;
  final String memberId;
  final Money amount;
  final DateTime paymentDate;
  final PaymentType paymentType;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final String? invoiceId;
  final String? membershipId;
  final String? description;
  final String? receiptNumber;
  final DateTime? periodStartDate;
  final DateTime? periodEndDate;
  final Money? remainingAmount;
  final DateTime recordedAt;
  final String? recordedBy;

  const MemberPaymentEntity({
    required this.id,
    required this.memberId,
    required this.amount,
    required this.paymentDate,
    required this.paymentType,
    required this.paymentMethod,
    required this.paymentStatus,
    this.invoiceId,
    this.membershipId,
    this.description,
    this.receiptNumber,
    this.periodStartDate,
    this.periodEndDate,
    this.remainingAmount,
    required this.recordedAt,
    this.recordedBy,
  });

  // Business Methods
  bool get isFullyPaid => paymentStatus == PaymentStatus.paid;
  
  bool get isPartiallyPaid => paymentStatus == PaymentStatus.partial;
  
  bool get isOverdue => paymentStatus == PaymentStatus.overdue;
  
  Money get remaining {
    if (isFullyPaid) return Money.zero(currency: amount.currency);
    return remainingAmount ?? amount;
  }

  int? get paymentPeriodDays {
    if (periodStartDate == null || periodEndDate == null) return null;
    return periodEndDate!.difference(periodStartDate!).inDays;
  }

  bool get isMembershipPayment => paymentType == PaymentType.membership;
  
  bool get isProductPayment => paymentType == PaymentType.product;
  
  bool get isServicePayment => paymentType == PaymentType.service;

  bool get isFreePayment => paymentMethod == PaymentMethod.free;

  double get paymentPercentage {
    if (amount.amount <= 0) return 100;
    final paid = amount.amount - remaining.amount;
    return (paid / amount.amount) * 100;
  }

  bool get isInPeriod => periodStartDate != null && periodEndDate != null;

  bool isWithinPeriod(DateTime date) {
    if (!isInPeriod) return false;
    return date.isAfter(periodStartDate!) && date.isBefore(periodEndDate!);
  }

  bool isOverdueOn(DateTime date) {
    if (isFullyPaid) return false;
    return paymentDate.isBefore(date) && remaining.amount > 0;
  }

  MemberPaymentEntity markAsPaid() {
    return copyWith(
      paymentStatus: PaymentStatus.paid,
      remainingAmount: Money.zero(currency: amount.currency),
    );
  }

  MemberPaymentEntity markAsPartial(Money partialAmount) {
    final newRemaining = remaining.subtract(partialAmount);
    return copyWith(
      paymentStatus: newRemaining.amount <= 0
          ? PaymentStatus.paid
          : PaymentStatus.partial,
      remainingAmount: newRemaining,
    );
  }

  MemberPaymentEntity markAsOverdue() {
    if (isFullyPaid) return this;
    return copyWith(paymentStatus: PaymentStatus.overdue);
  }

  MemberPaymentEntity cancel() {
    return copyWith(paymentStatus: PaymentStatus.cancelled);
  }

  MemberPaymentEntity copyWith({
    String? id,
    String? memberId,
    Money? amount,
    DateTime? paymentDate,
    PaymentType? paymentType,
    PaymentMethod? paymentMethod,
    PaymentStatus? paymentStatus,
    String? invoiceId,
    String? membershipId,
    String? description,
    String? receiptNumber,
    DateTime? periodStartDate,
    DateTime? periodEndDate,
    Money? remainingAmount,
    DateTime? recordedAt,
    String? recordedBy,
  }) {
    return MemberPaymentEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentType: paymentType ?? this.paymentType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      invoiceId: invoiceId ?? this.invoiceId,
      membershipId: membershipId ?? this.membershipId,
      description: description ?? this.description,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      periodStartDate: periodStartDate ?? this.periodStartDate,
      periodEndDate: periodEndDate ?? this.periodEndDate,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      recordedAt: recordedAt ?? this.recordedAt,
      recordedBy: recordedBy ?? this.recordedBy,
    );
  }

  @override
  List<Object?> get props => [
    id, memberId, amount, paymentDate, paymentType, paymentMethod,
    paymentStatus, invoiceId, membershipId, description, receiptNumber,
    periodStartDate, periodEndDate, remainingAmount, recordedAt, recordedBy,
  ];
}