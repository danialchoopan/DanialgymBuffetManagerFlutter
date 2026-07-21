import 'package:dartz/dartz.dart';
import '../entities/accounting/accounting_entities.dart';
import '../entities/member/member_payment_entity.dart';
import '../entities/value_objects/enums.dart';
import '../entities/value_objects/value_objects.dart';
import '../errors/failures.dart';

abstract class AccountingRepository {
  // Transaction Operations
  Future<Either<Failure, TransactionEntity>> addTransaction(TransactionEntity transaction);
  Future<Either<Failure, TransactionEntity>> updateTransaction(TransactionEntity transaction);
  Future<Either<Failure, void>> deleteTransaction(String id);
  Future<Either<Failure, TransactionEntity?>> getTransactionById(String id);
  Future<Either<Failure, TransactionEntity?>> getTransactionByNumber(String number);
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions();
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByType(TransactionCategory type);
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByCategory(String category);
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByDate(DateTime date);
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByDateRange(DateTime start, DateTime end);
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByMemberId(String memberId);
  Future<Either<Failure, List<TransactionEntity>>> getUnverifiedTransactions();
  Future<Either<Failure, TransactionEntity>> verifyTransaction(String transactionId, String verifierId);
  
  // Income Operations
  Future<Either<Failure, TransactionEntity>> recordIncome({
    required Money amount,
    required String category,
    String? description,
    String? referenceId,
    TransactionReferenceType? referenceType,
  });
  Future<Either<Failure, Money>> getTotalIncomeByDateRange(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, double>>> getIncomeByCategory(DateTime start, DateTime end);
  
  // Expense Operations
  Future<Either<Failure, TransactionEntity>> recordExpense({
    required Money amount,
    required String category,
    String? description,
    String? referenceId,
    TransactionReferenceType? referenceType,
  });
  Future<Either<Failure, Money>> getTotalExpensesByDateRange(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, double>>> getExpensesByCategory(DateTime start, DateTime end);
  
  // Invoice Operations
  Future<Either<Failure, InvoiceEntity>> generateInvoice(InvoiceEntity invoice);
  Future<Either<Failure, InvoiceEntity>> updateInvoice(InvoiceEntity invoice);
  Future<Either<Failure, void>> cancelInvoice(String invoiceId);
  Future<Either<Failure, InvoiceEntity?>> getInvoiceById(String id);
  Future<Either<Failure, InvoiceEntity?>> getInvoiceByNumber(String number);
  Future<Either<Failure, List<InvoiceEntity>>> getAllInvoices();
  Future<Either<Failure, List<InvoiceEntity>>> getInvoicesByMemberId(String memberId);
  Future<Either<Failure, List<InvoiceEntity>>> getInvoicesByStatus(InvoiceStatus status);
  Future<Either<Failure, List<InvoiceEntity>>> getOverdueInvoices();
  Future<Either<Failure, InvoiceEntity>> updateInvoicePayment(String invoiceId, Money amount);
  Future<Either<Failure, InvoiceEntity>> markInvoiceAsPaid(String invoiceId);
  
  // Payment Operations
  Future<Either<Failure, MemberPaymentEntity>> processPayment(MemberPaymentEntity payment);
  Future<Either<Failure, MemberPaymentEntity>> updatePayment(MemberPaymentEntity payment);
  Future<Either<Failure, void>> cancelPayment(String paymentId);
  Future<Either<Failure, List<MemberPaymentEntity>>> getPaymentsByMemberId(String memberId);
  Future<Either<Failure, List<MemberPaymentEntity>>> getPaymentsByStatus(PaymentStatus status);
  Future<Either<Failure, List<MemberPaymentEntity>>> getPaymentsByDateRange(DateTime start, DateTime end);
  Future<Either<Failure, List<MemberPaymentEntity>>> getOverduePayments();
  Future<Either<Failure, Money>> getTotalPaymentsByDateRange(DateTime start, DateTime end);
  
  // Financial Summary
  Future<Either<Failure, MemberFinancialSummaryEntity>> getMemberFinancialSummary(String memberId);
  Future<Either<Failure, DailyReportEntity>> getDailySummary(DateTime date);
  Future<Either<Failure, MonthlyReportEntity>> getMonthlySummary(int year, int month);
  Future<Either<Failure, YearlyReportEntity>> getYearlySummary(int year);
  Future<Either<Failure, ProfitLossEntity>> getProfitLossStatement(DateTime start, DateTime end);
  
  // Reports
  Future<Either<Failure, DailyReportEntity>> generateDailyReport(DateTime date);
  Future<Either<Failure, MonthlyReportEntity>> generateMonthlyReport(int year, int month);
  Future<Either<Failure, YearlyReportEntity>> generateYearlyReport(int year);
  Future<Either<Failure, ProfitLossEntity>> generateProfitLossReport(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, double>>> getRevenueBreakdown(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, double>>> getExpenseBreakdown(DateTime start, DateTime end);
  
  // Statistics
  Future<Either<Failure, Money>> getTotalRevenue();
  Future<Either<Failure, Money>> getTotalExpenses();
  Future<Either<Failure, Money>> getNetProfit();
  Future<Either<Failure, double>> getProfitMargin();
  Future<Either<Failure, Map<String, int>>> getTransactionCountByType();
  Future<Either<Failure, List<TransactionEntity>>> getRecentTransactions(int limit);
  Future<Either<Failure, List<MemberPaymentEntity>>> getRecentPayments(int limit);
}