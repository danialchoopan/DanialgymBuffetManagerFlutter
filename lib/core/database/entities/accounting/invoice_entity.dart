import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.invoicesTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['member_id'],
      parentColumns: ['id'],
      entity: MemberEntity,
    ),
  ],
)
class InvoiceEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'invoice_number')
  final String invoiceNumber;

  @ColumnInfo(name: 'member_id')
  final String memberId;

  @ColumnInfo(name: 'amount')
  final double amount;

  @ColumnInfo(name: 'tax_amount')
  final double taxAmount;

  @ColumnInfo(name: 'discount_amount')
  final double discountAmount;

  @ColumnInfo(name: 'total_amount')
  final double totalAmount;

  @ColumnInfo(name: 'status')
  final String status;

  @ColumnInfo(name: 'due_date')
  final DateTime dueDate;

  @ColumnInfo(name: 'paid_date')
  final DateTime? paidDate;

  @ColumnInfo(name: 'items')
  final String items;

  @ColumnInfo(name: 'notes')
  final String? notes;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  InvoiceEntity({
    required this.id,
    required this.invoiceNumber,
    required this.memberId,
    required this.amount,
    this.taxAmount = 0,
    this.discountAmount = 0,
    required this.totalAmount,
    required this.status,
    required this.dueDate,
    this.paidDate,
    required this.items,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isPaid => status == 'paid';
  bool get isOverdue => !isPaid && dueDate.isBefore(DateTime.now());

  InvoiceEntity copyWith({
    String? id,
    String? invoiceNumber,
    String? memberId,
    double? amount,
    double? taxAmount,
    double? discountAmount,
    double? totalAmount,
    String? status,
    DateTime? dueDate,
    DateTime? paidDate,
    String? items,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InvoiceEntity(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      memberId: memberId ?? this.memberId,
      amount: amount ?? this.amount,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      paidDate: paidDate ?? this.paidDate,
      items: items ?? this.items,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}