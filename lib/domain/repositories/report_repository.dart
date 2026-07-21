import 'package:dartz/dartz.dart';
import '../entities/report/report_entities.dart';
import '../errors/failures.dart';

abstract class ReportRepository {
  // Daily Reports
  Future<Either<Failure, DailyReportEntity>> generateDailyReport(DateTime date);
  Future<Either<Failure, DailyReportEntity?>> getDailyReport(DateTime date);
  
  // Monthly Reports
  Future<Either<Failure, MonthlyReportEntity>> generateMonthlyReport(int year, int month);
  Future<Either<Failure, MonthlyReportEntity?>> getMonthlyReport(int year, int month);
  
  // Yearly Reports
  Future<Either<Failure, YearlyReportEntity>> generateYearlyReport(int year);
  Future<Either<Failure, YearlyReportEntity?>> getYearlyReport(int year);
  
  // Financial Reports
  Future<Either<Failure, ProfitLossEntity>> generateProfitLossReport(DateTime start, DateTime end);
  Future<Either<Failure, ProfitLossEntity?>> getProfitLossReport(DateTime start, DateTime end);
  
  // Member Reports
  Future<Either<Failure, Map<String, dynamic>>> getMemberReport(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, dynamic>>> getMembershipReport();
  Future<Either<Failure, Map<String, dynamic>>> getMemberAttendanceReport(String memberId, DateTime start, DateTime end);
  Future<Either<Failure, Map<String, dynamic>>> getMemberPaymentReport(String memberId, DateTime start, DateTime end);
  Future<Either<Failure, Map<String, dynamic>>> getMemberWorkoutReport(String memberId, DateTime start, DateTime end);
  
  // Financial Reports
  Future<Either<Failure, FinancialReportEntity>> getFinancialReport(DateTime start, DateTime end);
  Future<Either<Failure, RevenueReportEntity>> getRevenueReport(DateTime start, DateTime end);
  Future<Either<Failure, ExpenseReportEntity>> getExpenseReport(DateTime start, DateTime end);
  
  // Attendance Reports
  Future<Either<Failure, AttendanceReportEntity>> getAttendanceReport(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, dynamic>>> getPeakHoursReport(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, dynamic>>> getMemberAttendanceTrend(String memberId);
  
  // Workout Reports
  Future<Either<Failure, WorkoutReportEntity>> getWorkoutReport(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, dynamic>>> getPopularExercisesReport();
  Future<Either<Failure, Map<String, dynamic>>> getTrainerPerformanceReport(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, dynamic>>> getMemberProgressReport(String memberId);
  
  // Buffet Reports
  Future<Either<Failure, BuffetReportEntity>> getBuffetReport(DateTime start, DateTime end);
  Future<Either<Failure, SalesReportEntity>> getSalesReport(DateTime start, DateTime end);
  Future<Either<Failure, InventoryReportEntity>> getInventoryReport();
  Future<Either<Failure, List<Map<String, dynamic>>>> getTopSellingProducts(DateTime start, DateTime end, int limit);
  Future<Either<Failure, Map<String, double>>> getSalesByCategory(DateTime start, DateTime end);
  
  // Dashboard
  Future<Either<Failure, Map<String, dynamic>>> getDashboardData();
  Future<Either<Failure, Map<String, dynamic>>> getRecentActivity(int limit);
  Future<Either<Failure, List<Map<String, dynamic>>>> getAlertsAndNotifications();
  Future<Either<Failure, Map<String, dynamic>>> getQuickStats();
  
  // Export
  Future<Either<Failure, String>> exportReportToPDF(String reportType, DateTime start, DateTime end);
  Future<Either<Failure, String>> exportReportToExcel(String reportType, DateTime start, DateTime end);
  Future<Either<Failure, String>> exportReportToCSV(String reportType, DateTime start, DateTime end);
}

// Additional Report Entities
class FinancialReportEntity {
  final DateTime startDate;
  final DateTime endDate;
  final double totalIncome;
  final double totalExpenses;
  final double netProfit;
  final double profitMargin;
  final Map<String, double> incomeBreakdown;
  final Map<String, double> expenseBreakdown;
  final List<Map<String, dynamic>> dailyTrends;

  FinancialReportEntity({
    required this.startDate,
    required this.endDate,
    required this.totalIncome,
    required this.totalExpenses,
    required this.netProfit,
    required this.profitMargin,
    required this.incomeBreakdown,
    required this.expenseBreakdown,
    required this.dailyTrends,
  });
}

class RevenueReportEntity {
  final DateTime startDate;
  final DateTime endDate;
  final double totalRevenue;
  final double membershipRevenue;
  final double productRevenue;
  final double trainingRevenue;
  final double otherRevenue;
  final Map<String, double> dailyRevenue;
  final Map<String, double> categoryBreakdown;

  RevenueReportEntity({
    required this.startDate,
    required this.endDate,
    required this.totalRevenue,
    required this.membershipRevenue,
    required this.productRevenue,
    required this.trainingRevenue,
    required this.otherRevenue,
    required this.dailyRevenue,
    required this.categoryBreakdown,
  });
}

class ExpenseReportEntity {
  final DateTime startDate;
  final DateTime endDate;
  final double totalExpenses;
  final double salaryExpenses;
  final double rentExpenses;
  final double utilityExpenses;
  final double supplyExpenses;
  final double otherExpenses;
  final Map<String, double> dailyExpenses;
  final Map<String, double> categoryBreakdown;

  ExpenseReportEntity({
    required this.startDate,
    required this.endDate,
    required this.totalExpenses,
    required this.salaryExpenses,
    required this.rentExpenses,
    required this.utilityExpenses,
    required this.supplyExpenses,
    required this.otherExpenses,
    required this.dailyExpenses,
    required this.categoryBreakdown,
  });
}

class AttendanceReportEntity {
  final DateTime startDate;
  final DateTime endDate;
  final int totalCheckIns;
  final int uniqueMembers;
  final double averageDuration;
  final Map<int, int> peakHours;
  final Map<String, int> dailyDistribution;
  final int averageDailyAttendance;

  AttendanceReportEntity({
    required this.startDate,
    required this.endDate,
    required this.totalCheckIns,
    required this.uniqueMembers,
    required this.averageDuration,
    required this.peakHours,
    required this.dailyDistribution,
    required this.averageDailyAttendance,
  });
}

class WorkoutReportEntity {
  final DateTime startDate;
  final DateTime endDate;
  final int totalWorkouts;
  final int uniqueMembers;
  final double averageDuration;
  final Map<String, int> exerciseDistribution;
  final Map<String, int> muscleGroupDistribution;
  final List<Map<String, dynamic>> topExercises;

  WorkoutReportEntity({
    required this.startDate,
    required this.endDate,
    required this.totalWorkouts,
    required this.uniqueMembers,
    required this.averageDuration,
    required this.exerciseDistribution,
    required this.muscleGroupDistribution,
    required this.topExercises,
  });
}

class BuffetReportEntity {
  final DateTime startDate;
  final DateTime endDate;
  final int totalOrders;
  final double totalSales;
  final double totalCost;
  final double totalProfit;
  final int totalItemsSold;
  final double averageOrderValue;
  final Map<String, int> categorySales;
  final Map<String, double> categoryRevenue;
  final List<Map<String, dynamic>> topProducts;

  BuffetReportEntity({
    required this.startDate,
    required this.endDate,
    required this.totalOrders,
    required this.totalSales,
    required this.totalCost,
    required this.totalProfit,
    required this.totalItemsSold,
    required this.averageOrderValue,
    required this.categorySales,
    required this.categoryRevenue,
    required this.topProducts,
  });
}

class SalesReportEntity {
  final DateTime startDate;
  final DateTime endDate;
  final double totalSales;
  final int totalOrders;
  final double averageOrderValue;
  final Map<String, double> dailySales;
  final Map<String, double> categoryBreakdown;
  final List<Map<String, dynamic>> topProducts;

  SalesReportEntity({
    required this.startDate,
    required this.endDate,
    required this.totalSales,
    required this.totalOrders,
    required this.averageOrderValue,
    required this.dailySales,
    required this.categoryBreakdown,
    required this.topProducts,
  });
}

class InventoryReportEntity {
  final int totalProducts;
  final double totalStockValue;
  final int lowStockItems;
  final int outOfStockItems;
  final List<Map<String, dynamic>> lowStockProducts;
  final Map<String, double> stockByCategory;

  InventoryReportEntity({
    required this.totalProducts,
    required this.totalStockValue,
    required this.lowStockItems,
    required this.outOfStockItems,
    required this.lowStockProducts,
    required this.stockByCategory,
  });
}