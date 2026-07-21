import 'package:equatable/equatable.dart';
import '../value_objects/value_objects.dart';

class DailyReportEntity extends Equatable {
  final DateTime date;
  final int totalMembers;
  final int activeMembers;
  final int newMembers;
  final int expiredMemberships;
  final Money totalIncome;
  final Money totalExpenses;
  final Money netProfit;
  final int totalOrders;
  final Money totalSales;
  final int totalAttendance;
  final Map<String, double> incomeBreakdown;
  final Map<String, double> expenseBreakdown;

  const DailyReportEntity({
    required this.date,
    required this.totalMembers,
    required this.activeMembers,
    required this.newMembers,
    required this.expiredMemberships,
    required this.totalIncome,
    required this.totalExpenses,
    required this.netProfit,
    required this.totalOrders,
    required this.totalSales,
    required this.totalAttendance,
    required this.incomeBreakdown,
    required this.expenseBreakdown,
  });

  // Business Methods
  Money get profitMargin {
    if (totalIncome.amount <= 0) return Money.zero();
    return netProfit.multiply(100 / totalIncome.amount);
  }

  double get attendanceRate {
    if (totalMembers <= 0) return 0;
    return (totalAttendance / totalMembers) * 100;
  }

  Money get averageOrderValue {
    if (totalOrders <= 0) return Money.zero();
    return totalSales.divide(totalOrders);
  }

  Map<String, double> get topIncomeCategories {
    final sorted = Map<String, double>.from(incomeBreakdown)
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted;
  }

  Map<String, double> get topExpenseCategories {
    final sorted = Map<String, double>.from(expenseBreakdown)
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted;
  }

  @override
  List<Object?> get props => [
    date, totalMembers, activeMembers, newMembers, expiredMemberships,
    totalIncome, totalExpenses, netProfit, totalOrders, totalSales,
    totalAttendance, incomeBreakdown, expenseBreakdown,
  ];
}

class MonthlyReportEntity extends Equatable {
  final int year;
  final int month;
  final int totalMembers;
  final int activeMembers;
  final int newMembers;
  final int churnedMembers;
  final Money totalIncome;
  final Money totalExpenses;
  final Money netProfit;
  final int totalOrders;
  final Money totalSales;
  final int totalAttendance;
  final double averageDailyAttendance;
  final Map<String, double> incomeBreakdown;
  final Map<String, double> expenseBreakdown;
  final List<Map<String, dynamic>> dailyTrends;

  const MonthlyReportEntity({
    required this.year,
    required this.month,
    required this.totalMembers,
    required this.activeMembers,
    required this.newMembers,
    required this.churnedMembers,
    required this.totalIncome,
    required this.totalExpenses,
    required this.netProfit,
    required this.totalOrders,
    required this.totalSales,
    required this.totalAttendance,
    required this.averageDailyAttendance,
    required this.incomeBreakdown,
    required this.expenseBreakdown,
    required this.dailyTrends,
  });

  // Business Methods
  Money get profitMargin {
    if (totalIncome.amount <= 0) return Money.zero();
    return netProfit.multiply(100 / totalIncome.amount);
  }

  double get memberRetentionRate {
    if (totalMembers <= 0) return 0;
    return ((totalMembers - churnedMembers) / totalMembers) * 100;
  }

  Money get averageOrderValue {
    if (totalOrders <= 0) return Money.zero();
    return totalSales.divide(totalOrders);
  }

  double get averageAttendancePerDay {
    final daysInMonth = DateTime(year, month + 1, 0).day;
    return totalAttendance / daysInMonth;
  }

  Map<String, double> get growthMetrics {
    return {
      'member_growth': totalMembers > 0 ? (newMembers / totalMembers) * 100 : 0,
      'revenue_growth': totalIncome.amount > 0 ? 0 : 0, // Need previous month data
      'expense_growth': totalExpenses.amount > 0 ? 0 : 0, // Need previous month data
    };
  }

  @override
  List<Object?> get props => [
    year, month, totalMembers, activeMembers, newMembers, churnedMembers,
    totalIncome, totalExpenses, netProfit, totalOrders, totalSales,
    totalAttendance, averageDailyAttendance, incomeBreakdown, expenseBreakdown,
    dailyTrends,
  ];
}

class YearlyReportEntity extends Equatable {
  final int year;
  final int totalMembers;
  final int activeMembers;
  final Money totalIncome;
  final Money totalExpenses;
  final Money netProfit;
  final int totalOrders;
  final Money totalSales;
  final int totalAttendance;
  final Map<String, double> monthlyIncome;
  final Map<String, double> monthlyExpenses;
  final Map<String, double> incomeBreakdown;
  final Map<String, double> expenseBreakdown;

  const YearlyReportEntity({
    required this.year,
    required this.totalMembers,
    required this.activeMembers,
    required this.totalIncome,
    required this.totalExpenses,
    required this.netProfit,
    required this.totalOrders,
    required this.totalSales,
    required this.totalAttendance,
    required this.monthlyIncome,
    required this.monthlyExpenses,
    required this.incomeBreakdown,
    required this.expenseBreakdown,
  });

  // Business Methods
  Money get profitMargin {
    if (totalIncome.amount <= 0) return Money.zero();
    return netProfit.multiply(100 / totalIncome.amount);
  }

  Money get averageMonthlyIncome => totalIncome.divide(12);

  Money get averageMonthlyExpenses => totalExpenses.divide(12);

  Money get averageMonthlyProfit => netProfit.divide(12);

  Money get averageOrderValue {
    if (totalOrders <= 0) return Money.zero();
    return totalSales.divide(totalOrders);
  }

  Map<String, double> get monthlyTrends {
    final trends = <String, double>{};
    for (var i = 1; i <= 12; i++) {
      final monthKey = i.toString().padLeft(2, '0');
      final income = monthlyIncome[monthKey] ?? 0;
      final expense = monthlyExpenses[monthKey] ?? 0;
      trends[monthKey] = income - expense;
    }
    return trends;
  }

  String get bestMonth {
    if (monthlyIncome.isEmpty) return 'N/A';
    return monthlyIncome.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  String get worstMonth {
    if (monthlyIncome.isEmpty) return 'N/A';
    return monthlyIncome.entries
        .reduce((a, b) => a.value < b.value ? a : b)
        .key;
  }

  @override
  List<Object?> get props => [
    year, totalMembers, activeMembers, totalIncome, totalExpenses,
    netProfit, totalOrders, totalSales, totalAttendance,
    monthlyIncome, monthlyExpenses, incomeBreakdown, expenseBreakdown,
  ];
}

class ProfitLossEntity extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final Money revenue;
  final Money costOfGoods;
  final Money grossProfit;
  final Money operatingExpenses;
  final Money operatingProfit;
  final Money otherIncome;
  final Money otherExpenses;
  final Money netProfit;
  final Map<String, double> revenueBreakdown;
  final Map<String, double> expenseBreakdown;

  const ProfitLossEntity({
    required this.startDate,
    required this.endDate,
    required this.revenue,
    required this.costOfGoods,
    required this.grossProfit,
    required this.operatingExpenses,
    required this.operatingProfit,
    required this.otherIncome,
    required this.otherExpenses,
    required this.netProfit,
    required this.revenueBreakdown,
    required this.expenseBreakdown,
  });

  // Business Methods
  Money get grossProfitMargin {
    if (revenue.amount <= 0) return Money.zero();
    return grossProfit.multiply(100 / revenue.amount);
  }

  Money get operatingProfitMargin {
    if (revenue.amount <= 0) return Money.zero();
    return operatingProfit.multiply(100 / revenue.amount);
  }

  Money get netProfitMargin {
    if (revenue.amount <= 0) return Money.zero();
    return netProfit.multiply(100 / revenue.amount);
  }

  Money get breakEvenPoint {
    if (grossProfitMargin.amount <= 0) return Money.zero();
    return operatingExpenses.divide(grossProfitMargin.amount / 100);
  }

  bool get isProfitable => netProfit.amount > 0;

  Map<String, double> get expenseRatios {
    if (operatingExpenses.amount <= 0) return {};
    final ratios = <String, double>{};
    expenseBreakdown.forEach((key, value) {
      ratios[key] = (value / operatingExpenses.amount) * 100;
    });
    return ratios;
  }

  @override
  List<Object?> get props => [
    startDate, endDate, revenue, costOfGoods, grossProfit,
    operatingExpenses, operatingProfit, otherIncome, otherExpenses,
    netProfit, revenueBreakdown, expenseBreakdown,
  ];
}

class SalesSummaryEntity extends Equatable {
  final DateTime date;
  final int totalOrders;
  final Money totalSales;
  final Money totalCost;
  final Money totalProfit;
  final int totalItemsSold;
  final double averageOrderValue;
  final Map<String, int> categorySales;
  final Map<String, double> categoryRevenue;

  const SalesSummaryEntity({
    required this.date,
    required this.totalOrders,
    required this.totalSales,
    required this.totalCost,
    required this.totalProfit,
    required this.totalItemsSold,
    required this.averageOrderValue,
    required this.categorySales,
    required this.categoryRevenue,
  });

  // Business Methods
  Money get profitMargin {
    if (totalSales.amount <= 0) return Money.zero();
    return totalProfit.multiply(100 / totalSales.amount);
  }

  String get topSellingCategory {
    if (categorySales.isEmpty) return 'N/A';
    return categorySales.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  String get topRevenueCategory {
    if (categoryRevenue.isEmpty) return 'N/A';
    return categoryRevenue.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  @override
  List<Object?> get props => [
    date, totalOrders, totalSales, totalCost, totalProfit,
    totalItemsSold, averageOrderValue, categorySales, categoryRevenue,
  ];
}