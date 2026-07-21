import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(tableName: DbConstants.productsTable)
class ProductEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'category_id')
  final String categoryId;

  @ColumnInfo(name: 'price')
  final double price;

  @ColumnInfo(name: 'cost_price')
  final double? costPrice;

  @ColumnInfo(name: 'sku')
  final String? sku;

  @ColumnInfo(name: 'barcode')
  final String? barcode;

  @ColumnInfo(name: 'image_path')
  final String? imagePath;

  @ColumnInfo(name: 'unit')
  final String unit;

  @ColumnInfo(name: 'is_available')
  final bool isAvailable;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  @ColumnInfo(name: DbConstants.isActiveColumn)
  final bool isActive;

  ProductEntity({
    required this.id,
    required this.name,
    this.description,
    required this.categoryId,
    required this.price,
    this.costPrice,
    this.sku,
    this.barcode,
    this.imagePath,
    this.unit = 'piece',
    this.isAvailable = true,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  ProductEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? categoryId,
    double? price,
    double? costPrice,
    String? sku,
    String? barcode,
    String? imagePath,
    String? unit,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      costPrice: costPrice ?? this.costPrice,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      imagePath: imagePath ?? this.imagePath,
      unit: unit ?? this.unit,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}