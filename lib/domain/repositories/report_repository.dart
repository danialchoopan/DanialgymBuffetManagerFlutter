import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ReportRepository {
  // Member Reports
  ResultFuture<Map<String, dynamic>> getMemberReport();
  ResultFuture<Map<String, dynamic>> getMembershipReport();
  ResultFuture<Map<String, dynamic>> getMemberAttendanceReport(String memberId);

  // Financial Reports
  ResultFuture<Map<String, dynamic>> getDailyFinancialReport(DateTime date);
  ResultFuture<Map<String, dynamic>> getMonthlyFinancialReport(int month, int year);
  ResultFuture<Map<String, dynamic>> getYearlyFinancialReport(int year);
  ResultFuture<Map<String, dynamic>> getProfitLossReport(DateTime startDate, DateTime endDate);
  ResultFuture<Map<String, dynamic>> getRevenueBreakdown(DateTime startDate, DateTime endDate);
  ResultFuture<Map<String, dynamic>> getExpenseBreakdown(DateTime startDate, DateTime endDate);

  // Workout Reports
  ResultFuture<Map<String, dynamic>> getWorkoutReport();
  ResultFuture<Map<String, dynamic>> getPopularExercises();
  ResultFuture<Map<String, dynamic>> getTrainerPerformanceReport();

  // Buffet Reports
  ResultFuture<Map<String, dynamic>> getBuffetReport();
  ResultFuture<Map<String, dynamic>> getInventoryReport();
  ResultFuture<Map<String, dynamic>> getSalesReport(DateTime startDate, DateTime endDate);
  ResultFuture<Map<String, dynamic>> getPopularProducts();

  // Dashboard
  ResultFuture<Map<String, dynamic>> getDashboardData();
  ResultFuture<Map<String, dynamic>> getRecentActivity();
  ResultFuture<Map<String, dynamic>> getAlertsAndNotifications();
}