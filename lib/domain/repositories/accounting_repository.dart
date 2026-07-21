import '../entities/accounting/payment_entity.dart';
import '../entities/accounting/transaction_entity.dart';
import '../entities/accounting/expense_entity.dart';
import '../entities/accounting/invoice_entity.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AccountingRepository {
  // Payments
  ResultFuture<List<PaymentEntity>> getAllPayments();
  ResultFuture<PaymentEntity?> getPaymentById(String id);
  ResultFuture<List<PaymentEntity>> getPaymentsByMemberId(String memberId);
  ResultFuture<List<PaymentEntity>> getPaymentsByStatus(String status);
  ResultFuture<List<PaymentEntity>> getPaymentsByDate(DateTime date);
  ResultFuture<double?> getTotalPaymentsByDate(String status, DateTime date);
  ResultFuture<void> addPayment(PaymentEntity payment);
  ResultFuture<void> updatePayment(PaymentEntity payment);

  // Transactions
  ResultFuture<List<TransactionEntity>> getAllTransactions();
  ResultFuture<TransactionEntity?> getTransactionById(String id);
  ResultFuture<List<TransactionEntity>> getTransactionsByType(String type);
  ResultFuture<List<TransactionEntity>> getTransactionsByCategory(String category);
  ResultFuture<List<TransactionEntity>> getTransactionsByDate(DateTime date);
  ResultFuture<void> addTransaction(TransactionEntity transaction);
  ResultFuture<void> updateTransaction(TransactionEntity transaction);

  // Expenses
  ResultFuture<List<ExpenseEntity>> getAllExpenses();
  ResultFuture<ExpenseEntity?> getExpenseById(String id);
  ResultFuture<List<ExpenseEntity>> getExpensesByCategory(String category);
  ResultFuture<List<ExpenseEntity>> getExpensesByDate(DateTime date);
  ResultFuture<double?> getTotalExpensesByCategoryAndDate(String category, DateTime date);
  ResultFuture<void> addExpense(ExpenseEntity expense);
  ResultFuture<void> updateExpense(ExpenseEntity expense);
  ResultFuture<void> deleteExpense(String id);

  // Invoices
  ResultFuture<List<InvoiceEntity>> getAllInvoices();
  ResultFuture<InvoiceEntity?> getInvoiceById(String id);
  ResultFuture<List<InvoiceEntity>> getInvoicesByMemberId(String memberId);
  ResultFuture<void> addInvoice(InvoiceEntity invoice);
  ResultFuture<void> updateInvoice(InvoiceEntity invoice);

  // Reports
  ResultFuture<double> getTotalIncome(DateTime startDate, DateTime endDate);
  ResultFuture<double> getTotalExpenses(DateTime startDate, DateTime endDate);
  ResultFuture<double> getNetProfit(DateTime startDate, DateTime endDate);
  ResultFuture<Map<String, double>> getIncomeByCategory(DateTime startDate, DateTime endDate);
  ResultFuture<Map<String, double>> getExpensesByCategory(DateTime startDate, DateTime endDate);
  ResultFuture<List<Map<String, dynamic>>> getDailyFinancialSummary(DateTime date);
  ResultFuture<List<Map<String, dynamic>>> getMonthlyFinancialSummary(int month, int year);
}