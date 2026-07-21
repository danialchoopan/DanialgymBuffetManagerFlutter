import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.orderItemsTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['order_id'],
      parentColumns: ['id'],
      entity: OrderEntity,
    ),
    ForeignKey(
      childColumns: ['product_id'],
      parentColumns: ['id'],
      entity: ProductEntity,
    ),
  ],
)
class OrderItemEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'order_id')
  final String orderId;

  @ColumnInfo(name: 'product_id')
  final String productId;

  @ColumnInfo(name: 'product_name')
  final String productName;

  @ColumnInfo(name: 'quantity')
  final int quantity;

  @ColumnInfo(name: 'unit_price')
  final double unitPrice;

  @ColumnInfo(name: 'total_price')
  final double totalPrice;

  @ColumnInfo(name: 'notes')
  final String? notes;

  OrderItemEntity({
    this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.notes,
  });

  OrderItemEntity copyWith({
    int? id,
    String? orderId,
    String? productId,
    String? productName,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    String? notes,
  }) {
    return OrderItemEntity(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      notes: notes ?? this.notes,
    );
  }
}