import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.ordersTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['member_id'],
      parentColumns: ['id'],
      entity: MemberEntity,
    ),
    ForeignKey(
      childColumns: ['staff_id'],
      parentColumns: ['id'],
      entity: StaffEntity,
    ),
  ],
)
class OrderEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'order_number')
  final String orderNumber;

  @ColumnInfo(name: 'member_id')
  final String? memberId;

  @ColumnInfo(name: 'staff_id')
  final String staffId;

  @ColumnInfo(name: 'total_amount')
  final double totalAmount;

  @ColumnInfo(name: 'discount_amount')
  final double discountAmount;

  @ColumnInfo(name: 'tax_amount')
  final double taxAmount;

  @ColumnInfo(name: 'final_amount')
  final double finalAmount;

  @ColumnInfo(name: 'payment_method')
  final String paymentMethod;

  @ColumnInfo(name: 'status')
  final String status;

  @ColumnInfo(name: 'notes')
  final String? notes;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  OrderEntity({
    required this.id,
    required this.orderNumber,
    this.memberId,
    required this.staffId,
    required this.totalAmount,
    this.discountAmount = 0,
    this.taxAmount = 0,
    required this.finalAmount,
    required this.paymentMethod,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  OrderEntity copyWith({
    String? id,
    String? orderNumber,
    String? memberId,
    String? staffId,
    double? totalAmount,
    double? discountAmount,
    double? taxAmount,
    double? finalAmount,
    String? paymentMethod,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      memberId: memberId ?? this.memberId,
      staffId: staffId ?? this.staffId,
      totalAmount: totalAmount ?? this.totalAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      finalAmount: finalAmount ?? this.finalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}