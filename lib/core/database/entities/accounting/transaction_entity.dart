import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(tableName: DbConstants.transactionsTable)
class TransactionEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'type')
  final String type;

  @ColumnInfo(name: 'category')
  final String category;

  @ColumnInfo(name: 'amount')
  final double amount;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'reference_id')
  final String? referenceId;

  @ColumnInfo(name: 'reference_type')
  final String? referenceType;

  @ColumnInfo(name: 'payment_method')
  final String? paymentMethod;

  @ColumnInfo(name: 'date')
  final DateTime date;

  @ColumnInfo(name: 'created_by')
  final String? createdBy;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  TransactionEntity({
    required this.id,
    required this.type,
    required this.category,
    required this.amount,
    this.description,
    this.referenceId,
    this.referenceType,
    this.paymentMethod,
    required this.date,
    this.createdBy,
    required this.createdAt,
  });

  bool get isIncome => type == 'income';
  bool get isExpense => type == 'expense';

  TransactionEntity copyWith({
    String? id,
    String? type,
    String? category,
    double? amount,
    String? description,
    String? referenceId,
    String? referenceType,
    String? paymentMethod,
    DateTime? date,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      referenceId: referenceId ?? this.referenceId,
      referenceType: referenceType ?? this.referenceType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      date: date ?? this.date,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}