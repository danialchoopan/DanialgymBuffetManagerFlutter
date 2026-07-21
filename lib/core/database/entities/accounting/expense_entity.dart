import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(tableName: DbConstants.expensesTable)
class ExpenseEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'category')
  final String category;

  @ColumnInfo(name: 'description')
  final String description;

  @ColumnInfo(name: 'amount')
  final double amount;

  @ColumnInfo(name: 'vendor')
  final String? vendor;

  @ColumnInfo(name: 'receipt_path')
  final String? receiptPath;

  @ColumnInfo(name: 'payment_method')
  final String paymentMethod;

  @ColumnInfo(name: 'expense_date')
  final DateTime expenseDate;

  @ColumnInfo(name: 'is_recurring')
  final bool isRecurring;

  @ColumnInfo(name: 'recurring_frequency')
  final String? recurringFrequency;

  @ColumnInfo(name: 'notes')
  final String? notes;

  @ColumnInfo(name: 'approved_by')
  final String? approvedBy;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  ExpenseEntity({
    required this.id,
    required this.category,
    required this.description,
    required this.amount,
    this.vendor,
    this.receiptPath,
    required this.paymentMethod,
    required this.expenseDate,
    this.isRecurring = false,
    this.recurringFrequency,
    this.notes,
    this.approvedBy,
    required this.createdAt,
  });

  ExpenseEntity copyWith({
    String? id,
    String? category,
    String? description,
    double? amount,
    String? vendor,
    String? receiptPath,
    String? paymentMethod,
    DateTime? expenseDate,
    bool? isRecurring,
    String? recurringFrequency,
    String? notes,
    String? approvedBy,
    DateTime? createdAt,
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      category: category ?? this.category,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      vendor: vendor ?? this.vendor,
      receiptPath: receiptPath ?? this.receiptPath,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      expenseDate: expenseDate ?? this.expenseDate,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringFrequency: recurringFrequency ?? this.recurringFrequency,
      notes: notes ?? this.notes,
      approvedBy: approvedBy ?? this.approvedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}