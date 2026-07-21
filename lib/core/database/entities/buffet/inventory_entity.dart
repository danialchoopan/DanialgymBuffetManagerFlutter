import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.inventoryTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['product_id'],
      parentColumns: ['id'],
      entity: ProductEntity,
    ),
  ],
)
class InventoryEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'product_id')
  final String productId;

  @ColumnInfo(name: 'product_name')
  final String productName;

  @ColumnInfo(name: 'current_stock')
  final int currentStock;

  @ColumnInfo(name: 'minimum_stock')
  final int minimumStock;

  @ColumnInfo(name: 'maximum_stock')
  final int maximumStock;

  @ColumnInfo(name: 'unit')
  final String unit;

  @ColumnInfo(name: 'last_restock_date')
  final DateTime? lastRestockDate;

  @ColumnInfo(name: 'last_restock_quantity')
  final int? lastRestockQuantity;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  InventoryEntity({
    this.id,
    required this.productId,
    required this.productName,
    required this.currentStock,
    required this.minimumStock,
    required this.maximumStock,
    this.unit = 'piece',
    this.lastRestockDate,
    this.lastRestockQuantity,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isLowStock => currentStock <= minimumStock;
  bool get isOutOfStock => currentStock <= 0;
  bool get needsRestock => currentStock <= minimumStock;

  InventoryEntity copyWith({
    int? id,
    String? productId,
    String? productName,
    int? currentStock,
    int? minimumStock,
    int? maximumStock,
    String? unit,
    DateTime? lastRestockDate,
    int? lastRestockQuantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InventoryEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      currentStock: currentStock ?? this.currentStock,
      minimumStock: minimumStock ?? this.minimumStock,
      maximumStock: maximumStock ?? this.maximumStock,
      unit: unit ?? this.unit,
      lastRestockDate: lastRestockDate ?? this.lastRestockDate,
      lastRestockQuantity: lastRestockQuantity ?? this.lastRestockQuantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}