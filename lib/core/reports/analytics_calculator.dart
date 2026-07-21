// ============================================================
// ANALYTICS CALCULATOR
// ============================================================
// This file contains all analytics calculations for generating
// reports and computing business metrics.
// ============================================================

import 'report_models.dart';

class AnalyticsCalculator {
  AnalyticsCalculator._();

  // ============================================================
  // MEMBER ANALYTICS
  // ============================================================

  static double calculateRetentionRate({
    required int activeMembers,
    required int totalMembers,
  }) {
    if (totalMembers == 0) return 0;
    return (activeMembers / totalMembers * 100);
  }

  static double calculateChurnRate({
    required int churnedMembers,
    required int totalMembers,
  }) {
    if (totalMembers == 0) return 0;
    return (churnedMembers / totalMembers * 100);
  }

  static double calculateMemberGrowthRate({
    required int newMembers,
    required int churnedMembers,
    required int totalMembers,
  }) {
    if (totalMembers == 0) return 0;
    return ((newMembers - churnedMembers) / totalMembers * 100);
  }

  static double calculateAverageAge(List<DateTime> birthDates) {
    if (birthDates.isEmpty) return 0;
    final now = DateTime.now();
    final totalAge = birthDates.fold<int>(0, (sum, birthDate) {
      int age = now.year - birthDate.year;
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }
      return sum + age;
    });
    return totalAge / birthDates.length;
  }

  static Map<String, double> calculateGenderDistribution({
    required int maleCount,
    required int femaleCount,
  }) {
    final total = maleCount + femaleCount;
    if (total == 0) return {'MALE': 0, 'FEMALE': 0};
    return {
      'MALE': (maleCount / total * 100),
      'FEMALE': (femaleCount / total * 100),
    };
  }

  static double calculateAverageMembershipDuration({
    required List<DateTime> joinDates,
    required List<DateTime> expiryDates,
  }) {
    if (joinDates.isEmpty) return 0;
    final now = DateTime.now();
    final totalDays = joinDates.asMap().entries.fold<int>(0, (sum, entry) {
      final index = entry.key;
      final joinDate = entry.value;
      final expiryDate = index < expiryDates.length ? expiryDates[index] : now;
      return sum + expiryDate.difference(joinDate).inDays;
    });
    return totalDays / joinDates.length;
  }

  // ============================================================
  // ATTENDANCE ANALYTICS
  // ============================================================

  static double calculateDailyAverage({
    required int totalAttendance,
    required int numberOfDays,
  }) {
    if (numberOfDays == 0) return 0;
    return totalAttendance / numberOfDays;
  }

  static double calculateWeeklyAverage({
    required int totalAttendance,
    required int numberOfWeeks,
  }) {
    if (numberOfWeeks == 0) return 0;
    return totalAttendance / numberOfWeeks;
  }

  static double calculateMonthlyAverage({
    required int totalAttendance,
    required int numberOfMonths,
  }) {
    if (numberOfMonths == 0) return 0;
    return totalAttendance / numberOfMonths;
  }

  static int findPeakHour(Map<int, int> hourlyDistribution) {
    if (hourlyDistribution.isEmpty) return 0;
    return hourlyDistribution.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  static String findPeakDay(Map<String, int> dailyDistribution) {
    if (dailyDistribution.isEmpty) return '';
    return dailyDistribution.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  static double calculateVisitFrequency({
    required int totalVisits,
    required int uniqueMembers,
    required int numberOfDays,
  }) {
    if (uniqueMembers == 0 || numberOfDays == 0) return 0;
    return totalVisits / uniqueMembers / numberOfDays;
  }

  static double calculateCapacityUtilization({
    required int attendance,
    required int capacity,
  }) {
    if (capacity == 0) return 0;
    return (attendance / capacity * 100).clamp(0, 100);
  }

  static double calculateAverageSessionDuration({
    required List<int> durationsMinutes,
  }) {
    if (durationsMinutes.isEmpty) return 0;
    final total = durationsMinutes.fold<int>(0, (sum, d) => sum + d);
    return total / durationsMinutes.length;
  }

  static Map<int, int> calculatePeakHours(List<DateTime> checkInTimes) {
    final hourly = <int, int>{};
    for (final time in checkInTimes) {
      final hour = time.hour;
      hourly[hour] = (hourly[hour] ?? 0) + 1;
    }
    return hourly;
  }

  static Map<String, int> calculateDailyDistribution(List<DateTime> dates) {
    final distribution = <String, int>{};
    final days = ['شنبه', 'یکشنبه', 'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنجشنبه', 'جمعه'];
    for (final date in dates) {
      final dayName = days[date.weekday % 7];
      distribution[dayName] = (distribution[dayName] ?? 0) + 1;
    }
    return distribution;
  }

  // ============================================================
  // FINANCIAL ANALYTICS
  // ============================================================

  static double calculateProfitMargin({
    required double revenue,
    required double profit,
  }) {
    if (revenue == 0) return 0;
    return (profit / revenue * 100);
  }

  static double calculateRevenuePerMember({
    required double totalRevenue,
    required int totalMembers,
  }) {
    if (totalMembers == 0) return 0;
    return totalRevenue / totalMembers;
  }

  static double calculateMonthOverMonthGrowth({
    required double currentMonth,
    required double previousMonth,
  }) {
    if (previousMonth == 0) return 0;
    return ((currentMonth - previousMonth) / previousMonth * 100);
  }

  static Map<String, double> calculateCategoryBreakdown({
    required Map<String, double> categoryAmounts,
  }) {
    final total = categoryAmounts.values.fold<double>(0, (a, b) => a + b);
    if (total == 0) return {};
    return categoryAmounts.map(
      (key, value) => MapEntry(key, value / total * 100),
    );
  }

  static double calculateNetProfit({
    required double income,
    required double expenses,
  }) {
    return income - expenses;
  }

  // ============================================================
  // BUFFET ANALYTICS
  // ============================================================

  static double calculateAverageOrderValue({
    required double totalRevenue,
    required int totalOrders,
  }) {
    if (totalOrders == 0) return 0;
    return totalRevenue / totalOrders;
  }

  static double calculateStockTurnover({
    required double costOfGoodsSold,
    required double averageInventory,
  }) {
    if (averageInventory == 0) return 0;
    return costOfGoodsSold / averageInventory;
  }

  static List<TopProductItem> calculateTopProducts({
    required Map<String, int> productQuantities,
    required Map<String, double> productRevenues,
    required Map<String, String> productNames,
    int limit = 10,
  }) {
    final products = productQuantities.entries.map((entry) {
      final productId = entry.key;
      return TopProductItem(
        productId: productId,
        productName: productNames[productId] ?? 'Unknown',
        quantitySold: entry.value,
        revenue: productRevenues[productId] ?? 0,
        rank: 0,
      );
    }).toList();

    products.sort((a, b) => b.quantitySold.compareTo(a.quantitySold));

    return products.take(limit).toList().asMap().entries.map((entry) {
      return TopProductItem(
        productId: entry.value.productId,
        productName: entry.value.productName,
        quantitySold: entry.value.quantitySold,
        revenue: entry.value.revenue,
        rank: entry.key + 1,
      );
    }).toList();
  }

  // ============================================================
  // WORKOUT ANALYTICS
  // ============================================================

  static double calculateOneRepMax(double weight, int reps) {
    if (reps == 1) return weight;
    return weight * (1 + reps / 30);
  }

  static double calculateTotalVolume({
    required int sets,
    required int reps,
    required double weight,
  }) {
    return sets * reps * weight;
  }

  static Map<String, int> calculateMuscleGroupDistribution({
    required List<String> muscleGroups,
  }) {
    final distribution = <String, int>{};
    for (final group in muscleGroups) {
      distribution[group] = (distribution[group] ?? 0) + 1;
    }
    return distribution;
  }

  static Map<String, int> calculateExercisePopularity({
    required List<String> exercises,
  }) {
    final popularity = <String, int>{};
    for (final exercise in exercises) {
      popularity[exercise] = (popularity[exercise] ?? 0) + 1;
    }
    return popularity;
  }

  // ============================================================
  // TREND CALCULATIONS
  // ============================================================

  static List<double> calculateTrend({
    required List<double> data,
    required int period,
  }) {
    if (data.length < period) return [];
    final trend = <double>[];
    for (var i = period; i < data.length; i++) {
      final sum = data.sublist(i - period, i).fold<double>(0, (a, b) => a + b);
      trend.add(sum / period);
    }
    return trend;
  }

  static double calculateMovingAverage({
    required List<double> data,
    required int window,
  }) {
    if (data.isEmpty) return 0;
    final recentData = data.length > window ? data.sublist(data.length - window) : data;
    return recentData.fold<double>(0, (a, b) => a + b) / recentData.length;
  }

  // ============================================================
  // COMPARISON CALCULATIONS
  // ============================================================

  static Map<String, double> calculatePeriodComparison({
    required Map<String, double> currentPeriod,
    required Map<String, double> previousPeriod,
  }) {
    final comparison = <String, double>{};
    for (final key in currentPeriod.keys) {
      final current = currentPeriod[key] ?? 0;
      final previous = previousPeriod[key] ?? 0;
      if (previous > 0) {
        comparison[key] = ((current - previous) / previous * 100);
      } else {
        comparison[key] = current > 0 ? 100 : 0;
      }
    }
    return comparison;
  }

  // ============================================================
  // KPI CALCULATIONS
  // ============================================================

  static Map<String, dynamic> calculateKPIs({
    required int totalMembers,
    required int activeMembers,
    required int todayAttendance,
    required double todayRevenue,
    required int pendingOrders,
    required int overduePayments,
    required int expiringMemberships,
    required int lowStockItems,
  }) {
    return {
      'total_members': totalMembers,
      'active_members': activeMembers,
      'active_percentage': totalMembers > 0 ? (activeMembers / totalMembers * 100) : 0,
      'today_attendance': todayAttendance,
      'today_revenue': todayRevenue,
      'pending_orders': pendingOrders,
      'overdue_payments': overduePayments,
      'expiring_memberships': expiringMemberships,
      'low_stock_items': lowStockItems,
    };
  }
}