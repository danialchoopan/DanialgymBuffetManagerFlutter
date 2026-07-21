import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.paymentsTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['member_id'],
      parentColumns: ['id'],
      entity: MemberEntity,
    ),
    ForeignKey(
      childColumns: ['invoice_id'],
      parentColumns: ['id'],
      entity: InvoiceEntity,
    ),
  ],
)
class PaymentEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'member_id')
  final String memberId;

  @ColumnInfo(name: 'invoice_id')
  final String? invoiceId;

  @ColumnInfo(name: 'amount')
  final double amount;

  @ColumnInfo(name: 'payment_method')
  final String paymentMethod;

  @ColumnInfo(name: 'payment_date')
  final DateTime paymentDate;

  @ColumnInfo(name: 'status')
  final String status;

  @ColumnInfo(name: 'reference')
  final String? reference;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'processed_by')
  final String? processedBy;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  PaymentEntity({
    required this.id,
    required this.memberId,
    this.invoiceId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentDate,
    required this.status,
    this.reference,
    this.description,
    this.processedBy,
    required this.createdAt,
  });

  PaymentEntity copyWith({
    String? id,
    String? memberId,
    String? invoiceId,
    double? amount,
    String? paymentMethod,
    DateTime? paymentDate,
    String? status,
    String? reference,
    String? description,
    String? processedBy,
    DateTime? createdAt,
  }) {
    return PaymentEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      invoiceId: invoiceId ?? this.invoiceId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentDate: paymentDate ?? this.paymentDate,
      status: status ?? this.status,
      reference: reference ?? this.reference,
      description: description ?? this.description,
      processedBy: processedBy ?? this.processedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}