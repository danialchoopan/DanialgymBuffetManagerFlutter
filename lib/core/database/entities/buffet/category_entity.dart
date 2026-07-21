import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(tableName: DbConstants.categoriesTable)
class CategoryEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'icon')
  final String? icon;

  @ColumnInfo(name: 'color')
  final String? color;

  @ColumnInfo(name: 'sort_order')
  final int sortOrder;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  @ColumnInfo(name: DbConstants.isActiveColumn)
  final bool isActive;

  CategoryEntity({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.color,
    this.sortOrder = 0,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  CategoryEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    String? color,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}