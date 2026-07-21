// ============================================================
// REPORT MODELS & SPECIFICATIONS
// ============================================================
// This file defines all report types, data models, and
// calculation specifications for the reporting system.
// ============================================================

import 'package:equatable/equatable.dart';

// ============================================================
// REPORT ENUMS
// ============================================================

enum ReportType {
  member,
  attendance,
  workout,
  buffet,
  financial,
  combined,
  custom,
}

enum ReportPeriod {
  daily,
  weekly,
  monthly,
  yearly,
  custom,
}

enum ExportFormat {
  pdf,
  csv,
  excel,
  html,
  json,
}

enum ChartType {
  bar,
  line,
  pie,
  doughnut,
  heatmap,
  gauge,
  progress,
}

// ============================================================
// BASE REPORT MODEL
// ============================================================

class ReportMetadata extends Equatable {
  final String id;
  final String title;
  final ReportType type;
  final ReportPeriod period;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime generatedAt;
  final String? generatedBy;
  final ExportFormat format;
  final String? filePath;

  const ReportMetadata({
    required this.id,
    required this.title,
    required this.type,
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.generatedAt,
    this.generatedBy,
    this.format = ExportFormat.pdf,
    this.filePath,
  });

  String get periodLabel {
    switch (period) {
      case ReportPeriod.daily:
        return 'روزانه';
      case ReportPeriod.weekly:
        return 'هفتگی';
      case ReportPeriod.monthly:
        return 'ماهانه';
      case ReportPeriod.yearly:
        return 'سالانه';
      case ReportPeriod.custom:
        return 'سفارشی';
    }
  }

  String get typeLabel {
    switch (type) {
      case ReportType.member:
        return 'اعضا';
      case ReportType.attendance:
        return 'حضور و غیاب';
      case ReportType.workout:
        return 'تمرینات';
      case ReportType.buffet:
        return 'بوفه';
      case ReportType.financial:
        return 'مالی';
      case ReportType.combined:
        return 'ترکیبی';
      case ReportType.custom:
        return 'سفارشی';
    }
  }

  @override
  List<Object?> get props => [id, title, type, period, startDate, endDate];
}

// ============================================================
// MEMBER REPORTS
// ============================================================

class MemberReportData extends Equatable {
  final int totalMembers;
  final int activeMembers;
  final int expiredMembers;
  final int suspendedMembers;
  final int pendingMembers;
  final int newMembersInPeriod;
  final int churnedMembers;
  final double retentionRate;
  final double churnRate;
  final double averageAge;
  final Map<String, int> genderDistribution;
  final Map<String, int> membershipTypeDistribution;
  final List<MemberListItem> recentMembers;
  final List<MemberListItem> expiringMembers;
  final List<MemberListItem> overdueMembers;

  const MemberReportData({
    required this.totalMembers,
    required this.activeMembers,
    required this.expiredMembers,
    required this.suspendedMembers,
    required this.pendingMembers,
    required this.newMembersInPeriod,
    required this.churnedMembers,
    required this.retentionRate,
    required this.churnRate,
    required this.averageAge,
    required this.genderDistribution,
    required this.membershipTypeDistribution,
    required this.recentMembers,
    required this.expiringMembers,
    required this.overdueMembers,
  });

  double get activePercentage =>
      totalMembers > 0 ? (activeMembers / totalMembers * 100) : 0;

  double get expiredPercentage =>
      totalMembers > 0 ? (expiredMembers / totalMembers * 100) : 0;

  @override
  List<Object?> get props => [totalMembers, activeMembers, newMembersInPeriod];
}

class MemberListItem extends Equatable {
  final String id;
  final String fullName;
  final String phone;
  final String membershipStatus;
  final DateTime? membershipExpiry;
  final double outstandingBalance;
  final int totalVisits;

  const MemberListItem({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.membershipStatus,
    this.membershipExpiry,
    this.outstandingBalance = 0,
    this.totalVisits = 0,
  });

  @override
  List<Object?> get props => [id, fullName, membershipStatus];
}

// ============================================================
// ATTENDANCE REPORTS
// ============================================================

class AttendanceReportData extends Equatable {
  final int totalCheckIns;
  final int uniqueMembers;
  final double averageDurationMinutes;
  final Map<int, int> hourlyDistribution;
  final Map<String, int> dailyDistribution;
  final Map<String, int> weeklyDistribution;
  final List<PeakHourData> peakHours;
  final int peakHour;
  final String peakDay;
  final double averageDailyAttendance;
  final double capacityUtilization;

  const AttendanceReportData({
    required this.totalCheckIns,
    required this.uniqueMembers,
    required this.averageDurationMinutes,
    required this.hourlyDistribution,
    required this.dailyDistribution,
    required this.weeklyDistribution,
    required this.peakHours,
    required this.peakHour,
    required this.peakDay,
    required this.averageDailyAttendance,
    required this.capacityUtilization,
  });

  String get averageDurationFormatted {
    final hours = averageDurationMinutes ~/ 60;
    final minutes = averageDurationMinutes % 60;
    if (hours == 0) return '$minutes دقیقه';
    if (minutes == 0) return '$hours ساعت';
    return '$hours ساعت و $minutes دقیقه';
  }

  @override
  List<Object?> get props => [totalCheckIns, uniqueMembers, peakHour];
}

class PeakHourData extends Equatable {
  final int hour;
  final int count;
  final double percentage;

  const PeakHourData({
    required this.hour,
    required this.count,
    required this.percentage,
  });

  String get hourLabel => '${hour.toString().padLeft(2, '0')}:00';

  @override
  List<Object?> get props => [hour, count];
}

// ============================================================
// WORKOUT REPORTS
// ============================================================

class WorkoutReportData extends Equatable {
  final int totalWorkoutsLogged;
  final int uniqueMembersWorkingOut;
  final double averageWorkoutDuration;
  final int totalExercisesPerformed;
  final Map<String, int> muscleGroupDistribution;
  final Map<String, int> exercisePopularity;
  final List<TrainerPerformanceItem> trainerPerformance;
  final List<ProgressSummaryItem> topProgress;

  const WorkoutReportData({
    required this.totalWorkoutsLogged,
    required this.uniqueMembersWorkingOut,
    required this.averageWorkoutDuration,
    required this.totalExercisesPerformed,
    required this.muscleGroupDistribution,
    required this.exercisePopularity,
    required this.trainerPerformance,
    required this.topProgress,
  });

  @override
  List<Object?> get props => [totalWorkoutsLogged, uniqueMembersWorkingOut];
}

class TrainerPerformanceItem extends Equatable {
  final String trainerId;
  final String trainerName;
  final int totalSessions;
  final int assignedMembers;
  final double satisfactionRating;
  final double totalEarnings;

  const TrainerPerformanceItem({
    required this.trainerId,
    required this.trainerName,
    required this.totalSessions,
    required this.assignedMembers,
    required this.satisfactionRating,
    required this.totalEarnings,
  });

  @override
  List<Object?> get props => [trainerId, totalSessions];
}

class ProgressSummaryItem extends Equatable {
  final String memberId;
  final String memberName;
  final double weightChange;
  final double bodyFatChange;
  final double muscleMassChange;
  final int workoutsCompleted;

  const ProgressSummaryItem({
    required this.memberId,
    required this.memberName,
    required this.weightChange,
    required this.bodyFatChange,
    required this.muscleMassChange,
    required this.workoutsCompleted,
  });

  bool get isPositiveProgress =>
      weightChange < 0 && bodyFatChange < 0 && muscleMassChange > 0;

  @override
  List<Object?> get props => [memberId, weightChange];
}

// ============================================================
// BUFFET REPORTS
// ============================================================

class BuffetReportData extends Equatable {
  final int totalOrders;
  final double totalRevenue;
  final double totalCost;
  final double totalProfit;
  final double averageOrderValue;
  final int totalItemsSold;
  final List<TopProductItem> topProducts;
  final List<CategoryPerformanceItem> categoryPerformance;
  final Map<String, int> orderStatusBreakdown;
  final Map<String, double> dailyRevenue;
  final List<LowStockItem> lowStockItems;

  const BuffetReportData({
    required this.totalOrders,
    required this.totalRevenue,
    required this.totalCost,
    required this.totalProfit,
    required this.averageOrderValue,
    required this.totalItemsSold,
    required this.topProducts,
    required this.categoryPerformance,
    required this.orderStatusBreakdown,
    required this.dailyRevenue,
    required this.lowStockItems,
  });

  double get profitMargin =>
      totalRevenue > 0 ? (totalProfit / totalRevenue * 100) : 0;

  @override
  List<Object?> get props => [totalOrders, totalRevenue, totalProfit];
}

class TopProductItem extends Equatable {
  final String productId;
  final String productName;
  final int quantitySold;
  final double revenue;
  final int rank;

  const TopProductItem({
    required this.productId,
    required this.productName,
    required this.quantitySold,
    required this.revenue,
    required this.rank,
  });

  @override
  List<Object?> get props => [productId, quantitySold];
}

class CategoryPerformanceItem extends Equatable {
  final String categoryId;
  final String categoryName;
  final int orderCount;
  final double revenue;
  final double percentage;

  const CategoryPerformanceItem({
    required this.categoryId,
    required this.categoryName,
    required this.orderCount,
    required this.revenue,
    required this.percentage,
  });

  @override
  List<Object?> get props => [categoryId, revenue];
}

class LowStockItem extends Equatable {
  final String productId;
  final String productName;
  final double currentStock;
  final double minStockLevel;
  final String unit;

  const LowStockItem({
    required this.productId,
    required this.productName,
    required this.currentStock,
    required this.minStockLevel,
    required this.unit,
  });

  bool get isOutOfStock => currentStock <= 0;

  @override
  List<Object?> get props => [productId, currentStock];
}

// ============================================================
// FINANCIAL REPORTS
// ============================================================

class FinancialReportData extends Equatable {
  final double totalIncome;
  final double totalExpenses;
  final double netProfit;
  final double profitMargin;
  final Map<String, double> incomeByCategory;
  final Map<String, double> expensesByCategory;
  final List<TransactionSummaryItem> topTransactions;
  final Map<String, double> dailyTrend;
  final double previousPeriodIncome;
  final double previousPeriodExpenses;

  const FinancialReportData({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netProfit,
    required this.profitMargin,
    required this.incomeByCategory,
    required this.expensesByCategory,
    required this.topTransactions,
    required this.dailyTrend,
    this.previousPeriodIncome = 0,
    this.previousPeriodExpenses = 0,
  });

  double get incomeGrowth => previousPeriodIncome > 0
      ? ((totalIncome - previousPeriodIncome) / previousPeriodIncome * 100)
      : 0;

  double get expenseGrowth => previousPeriodExpenses > 0
      ? ((totalExpenses - previousPeriodExpenses) / previousPeriodExpenses * 100)
      : 0;

  @override
  List<Object?> get props => [totalIncome, totalExpenses, netProfit];
}

class TransactionSummaryItem extends Equatable {
  final String transactionId;
  final String category;
  final double amount;
  final String type;
  final DateTime date;
  final String? description;

  const TransactionSummaryItem({
    required this.transactionId,
    required this.category,
    required this.amount,
    required this.type,
    required this.date,
    this.description,
  });

  bool get isIncome => type == 'INCOME';

  @override
  List<Object?> get props => [transactionId, amount];
}

// ============================================================
// COMBINED DAILY REPORT
// ============================================================

class DailyReportData extends Equatable {
  final ReportMetadata metadata;
  final MemberReportData memberData;
  final AttendanceReportData attendanceData;
  final BuffetReportData buffetData;
  final FinancialReportData financialData;
  final List<AlertItem> alerts;

  const DailyReportData({
    required this.metadata,
    required this.memberData,
    required this.attendanceData,
    required this.buffetData,
    required this.financialData,
    required this.alerts,
  });

  @override
  List<Object?> get props => [metadata, memberData, attendanceData, buffetData, financialData];
}

class AlertItem extends Equatable {
  final String type;
  final String title;
  final String message;
  final String severity;
  final DateTime createdAt;

  const AlertItem({
    required this.type,
    required this.title,
    required this.message,
    required this.severity,
    required this.createdAt,
  });

  bool get isHighSeverity => severity == 'HIGH';
  bool get isMediumSeverity => severity == 'MEDIUM';
  bool get isLowSeverity => severity == 'LOW';

  @override
  List<Object?> get props => [type, title, severity];
}

// ============================================================
// CHART DATA MODELS
// ============================================================

class ChartData extends Equatable {
  final String title;
  final ChartType type;
  final List<ChartDataSet> datasets;
  final List<String>? labels;

  const ChartData({
    required this.title,
    required this.type,
    required this.datasets,
    this.labels,
  });

  @override
  List<Object?> get props => [title, type, datasets];
}

class ChartDataSet extends Equatable {
  final String label;
  final List<double> data;
  final Color? color;

  const ChartDataSet({
    required this.label,
    required this.data,
    this.color,
  });

  double get sum => data.fold(0, (a, b) => a + b);
  double get average => data.isEmpty ? 0 : sum / data.length;
  double get max => data.isEmpty ? 0 : data.reduce((a, b) => a > b ? a : b);
  double get min => data.isEmpty ? 0 : data.reduce((a, b) => a < b ? a : b);

  @override
  List<Object?> get props => [label, data];
}

class PieChartData extends Equatable {
  final String label;
  final double value;
  final Color color;
  final double percentage;

  const PieChartData({
    required this.label,
    required this.value,
    required this.color,
    required this.percentage,
  });

  @override
  List<Object?> get props => [label, value];
}