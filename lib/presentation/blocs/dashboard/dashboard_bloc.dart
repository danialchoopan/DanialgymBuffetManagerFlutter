import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// DASHBOARD STATES
// ============================================================

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  final String? message;

  const DashboardLoading({this.message});

  @override
  List<Object?> get props => [message];
}

class DashboardLoaded extends DashboardState {
  final QuickStats quickStats;
  final List<RecentActivity> recentActivity;
  final List<AlertItem> alerts;
  final ChartsData chartsData;

  const DashboardLoaded({
    required this.quickStats,
    required this.recentActivity,
    required this.alerts,
    required this.chartsData,
  });

  @override
  List<Object?> get props => [quickStats, recentActivity, alerts, chartsData];
}

class DashboardError extends DashboardState {
  final String message;
  final String? code;

  const DashboardError({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

// ============================================================
// DASHBOARD DATA MODELS
// ============================================================

class QuickStats extends Equatable {
  final int totalMembers;
  final int activeMembers;
  final int todayAttendance;
  final double todayRevenue;
  final int pendingOrders;
  final int overduePayments;
  final int expiringMemberships;

  const QuickStats({
    required this.totalMembers,
    required this.activeMembers,
    required this.todayAttendance,
    required this.todayRevenue,
    required this.pendingOrders,
    required this.overduePayments,
    required this.expiringMemberships,
  });

  @override
  List<Object?> get props => [
    totalMembers, activeMembers, todayAttendance,
    todayRevenue, pendingOrders, overduePayments, expiringMemberships,
  ];
}

class RecentActivity extends Equatable {
  final String id;
  final String type;
  final String title;
  final String? subtitle;
  final DateTime timestamp;
  final String? icon;
  final String? color;

  const RecentActivity({
    required this.id,
    required this.type,
    required this.title,
    this.subtitle,
    required this.timestamp,
    this.icon,
    this.color,
  });

  @override
  List<Object?> get props => [id, type, title, subtitle, timestamp, icon, color];
}

class AlertItem extends Equatable {
  final String id;
  final String type;
  final String title;
  final String message;
  final DateTime createdAt;
  final bool isRead;
  final String? actionRoute;

  const AlertItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.createdAt,
    this.isRead = false,
    this.actionRoute,
  });

  @override
  List<Object?> get props => [id, type, title, message, createdAt, isRead, actionRoute];
}

class ChartsData extends Equatable {
  final List<ChartPoint> weeklyAttendance;
  final List<ChartPoint> weeklyRevenue;
  final Map<String, double> membershipDistribution;
  final Map<String, double> revenueByCategory;

  const ChartsData({
    required this.weeklyAttendance,
    required this.weeklyRevenue,
    required this.membershipDistribution,
    required this.revenueByCategory,
  });

  @override
  List<Object?> get props => [weeklyAttendance, weeklyRevenue, membershipDistribution, revenueByCategory];
}

class ChartPoint extends Equatable {
  final String label;
  final double value;

  const ChartPoint({required this.label, required this.value});

  @override
  List<Object?> get props => [label, value];
}

// ============================================================
// DASHBOARD EVENTS
// ============================================================

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardRequested extends DashboardEvent {
  const LoadDashboardRequested();
}

class RefreshDashboardRequested extends DashboardEvent {
  const RefreshDashboardRequested();
}

class FetchQuickStatsRequested extends DashboardEvent {
  const FetchQuickStatsRequested();
}

class FetchRecentActivityRequested extends DashboardEvent {
  final int limit;

  const FetchRecentActivityRequested({this.limit = 10});

  @override
  List<Object?> get props => [limit];
}

class FetchChartsDataRequested extends DashboardEvent {
  const FetchChartsDataRequested();
}

class GetNotificationsRequested extends DashboardEvent {
  const GetNotificationsRequested();
}

class MarkAlertReadRequested extends DashboardEvent {
  final String alertId;

  const MarkAlertReadRequested({required this.alertId});

  @override
  List<Object?> get props => [alertId];
}

class ClearAllAlertsRequested extends DashboardEvent {
  const ClearAllAlertsRequested();
}

// ============================================================
// DASHBOARD BLOC
// ============================================================

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  // Dependencies would be injected via constructor

  DashboardBloc() : super(const DashboardInitial()) {
    on<LoadDashboardRequested>(_onLoadDashboard);
    on<RefreshDashboardRequested>(_onRefreshDashboard);
    on<FetchQuickStatsRequested>(_onFetchQuickStats);
    on<FetchRecentActivityRequested>(_onFetchRecentActivity);
    on<FetchChartsDataRequested>(_onFetchChartsData);
    on<GetNotificationsRequested>(_onGetNotifications);
    on<MarkAlertReadRequested>(_onMarkAlertRead);
    on<ClearAllAlertsRequested>(_onClearAllAlerts);
  }

  // ============================================================
  // EVENT HANDLERS
  // ============================================================

  Future<void> _onLoadDashboard(
    LoadDashboardRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading(message: 'در حال بارگذاری داشبورد...'));

    try {
      // Load all dashboard data in parallel
      final results = await Future.wait([
        _fetchQuickStats(),
        _fetchRecentActivity(10),
        _fetchAlerts(),
        _fetchChartsData(),
      ]);

      final quickStats = results[0] as QuickStats;
      final recentActivity = results[1] as List<RecentActivity>;
      final alerts = results[2] as List<AlertItem>;
      final chartsData = results[3] as ChartsData;

      emit(DashboardLoaded(
        quickStats: quickStats,
        recentActivity: recentActivity,
        alerts: alerts,
        chartsData: chartsData,
      ));
    } catch (e) {
      emit(DashboardError(
        message: 'خطا در بارگذاری داشبورد.',
        code: 'LOAD_DASHBOARD_ERROR',
      ));
    }
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboardRequested event,
    Emitter<DashboardState> emit,
  ) async {
    add(const LoadDashboardRequested());
  }

  Future<void> _onFetchQuickStats(
    FetchQuickStatsRequested event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final quickStats = await _fetchQuickStats();

      final currentState = state;
      if (currentState is DashboardLoaded) {
        emit(DashboardLoaded(
          quickStats: quickStats,
          recentActivity: currentState.recentActivity,
          alerts: currentState.alerts,
          chartsData: currentState.chartsData,
        ));
      }
    } catch (e) {
      // Silently fail for partial updates
    }
  }

  Future<void> _onFetchRecentActivity(
    FetchRecentActivityRequested event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final recentActivity = await _fetchRecentActivity(event.limit);

      final currentState = state;
      if (currentState is DashboardLoaded) {
        emit(DashboardLoaded(
          quickStats: currentState.quickStats,
          recentActivity: recentActivity,
          alerts: currentState.alerts,
          chartsData: currentState.chartsData,
        ));
      }
    } catch (e) {
      // Silently fail for partial updates
    }
  }

  Future<void> _onFetchChartsData(
    FetchChartsDataRequested event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final chartsData = await _fetchChartsData();

      final currentState = state;
      if (currentState is DashboardLoaded) {
        emit(DashboardLoaded(
          quickStats: currentState.quickStats,
          recentActivity: currentState.recentActivity,
          alerts: currentState.alerts,
          chartsData: chartsData,
        ));
      }
    } catch (e) {
      // Silently fail for partial updates
    }
  }

  Future<void> _onGetNotifications(
    GetNotificationsRequested event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final alerts = await _fetchAlerts();

      final currentState = state;
      if (currentState is DashboardLoaded) {
        emit(DashboardLoaded(
          quickStats: currentState.quickStats,
          recentActivity: currentState.recentActivity,
          alerts: alerts,
          chartsData: currentState.chartsData,
        ));
      }
    } catch (e) {
      // Silently fail for partial updates
    }
  }

  Future<void> _onMarkAlertRead(
    MarkAlertReadRequested event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      await _markAlertAsRead(event.alertId);

      final currentState = state;
      if (currentState is DashboardLoaded) {
        final updatedAlerts = currentState.alerts.map((alert) {
          if (alert.id == event.alertId) {
            return AlertItem(
              id: alert.id,
              type: alert.type,
              title: alert.title,
              message: alert.message,
              createdAt: alert.createdAt,
              isRead: true,
              actionRoute: alert.actionRoute,
            );
          }
          return alert;
        }).toList();

        emit(DashboardLoaded(
          quickStats: currentState.quickStats,
          recentActivity: currentState.recentActivity,
          alerts: updatedAlerts,
          chartsData: currentState.chartsData,
        ));
      }
    } catch (e) {
      // Silently fail for partial updates
    }
  }

  Future<void> _onClearAllAlerts(
    ClearAllAlertsRequested event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      await _clearAllAlerts();

      final currentState = state;
      if (currentState is DashboardLoaded) {
        emit(DashboardLoaded(
          quickStats: currentState.quickStats,
          recentActivity: currentState.recentActivity,
          alerts: [],
          chartsData: currentState.chartsData,
        ));
      }
    } catch (e) {
      // Silently fail for partial updates
    }
  }

  // ============================================================
  // PRIVATE HELPER METHODS
  // ============================================================

  Future<QuickStats> _fetchQuickStats() async {
    // Placeholder - would fetch from repositories
    await Future.delayed(const Duration(milliseconds: 500));

    return const QuickStats(
      totalMembers: 256,
      activeMembers: 198,
      todayAttendance: 45,
      todayRevenue: 2450.0,
      pendingOrders: 5,
      overduePayments: 12,
      expiringMemberships: 8,
    );
  }

  Future<List<RecentActivity>> _fetchRecentActivity(int limit) async {
    // Placeholder - would fetch from repositories
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      RecentActivity(
        id: '1',
        type: 'CHECK_IN',
        title: 'ورود عضو',
        subtitle: 'علی محمدی وارد شد',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        icon: 'login',
        color: '#4CAF50',
      ),
      RecentActivity(
        id: '2',
        type: 'ORDER',
        title: 'سفارش جدید',
        subtitle: 'سفارش #1234 - 45,000 تومان',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        icon: 'shopping_cart',
        color: '#2196F3',
      ),
      RecentActivity(
        id: '3',
        type: 'PAYMENT',
        title: 'پرداخت دریافتی',
        subtitle: 'رضا احمدی - 500,000 تومان',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        icon: 'payment',
        color: '#FF9800',
      ),
      RecentActivity(
        id: '4',
        type: 'NEW_MEMBER',
        title: 'عضو جدید',
        subtitle: 'سارا کریمی ثبت نام کرد',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        icon: 'person_add',
        color: '#9C27B0',
      ),
    ];
  }

  Future<List<AlertItem>> _fetchAlerts() async {
    // Placeholder - would fetch from repositories
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      AlertItem(
        id: '1',
        type: 'MEMBERSHIP_EXPIRING',
        title: 'عضویت در حال انقضا',
        message: '8 عضویت تا 7 روز آینده منقضی می‌شود',
        createdAt: DateTime.now(),
        actionRoute: '/members/expiring',
      ),
      AlertItem(
        id: '2',
        type: 'LOW_STOCK',
        title: 'موجودی کم',
        message: '3 محصول زیر حداقل موجودی هستند',
        createdAt: DateTime.now(),
        actionRoute: '/buffet/low-stock',
      ),
      AlertItem(
        id: '3',
        type: 'OVERDUE_PAYMENT',
        title: 'پرداخت معوق',
        message: '12 عضو پرداخت معوق دارند',
        createdAt: DateTime.now(),
        actionRoute: '/accounting/overdue',
      ),
    ];
  }

  Future<ChartsData> _fetchChartsData() async {
    // Placeholder - would fetch from repositories
    await Future.delayed(const Duration(milliseconds: 500));

    return const ChartsData(
      weeklyAttendance: [
        ChartPoint(label: 'شنبه', value: 45),
        ChartPoint(label: 'یکشنبه', value: 52),
        ChartPoint(label: 'دوشنبه', value: 48),
        ChartPoint(label: 'سه‌شنبه', value: 61),
        ChartPoint(label: 'چهارشنبه', value: 55),
        ChartPoint(label: 'پنجشنبه', value: 42),
        ChartPoint(label: 'جمعه', value: 38),
      ],
      weeklyRevenue: [
        ChartPoint(label: 'شنبه', value: 2450),
        ChartPoint(label: 'یکشنبه', value: 3120),
        ChartPoint(label: 'دوشنبه', value: 2890),
        ChartPoint(label: 'سه‌شنبه', value: 3450),
        ChartPoint(label: 'چهارشنبه', value: 2780),
        ChartPoint(label: 'پنجشنبه', value: 2340),
        ChartPoint(label: 'جمعه', value: 1890),
      ],
      membershipDistribution: {
        'ماهانه': 45,
        'سه‌ماهه': 30,
        'سالانه': 20,
        'ابدی': 5,
      },
      revenueByCategory: {
        'عضویت': 60,
        'محصولات': 25,
        'آموزش': 15,
      },
    );
  }

  Future<void> _markAlertAsRead(String alertId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _clearAllAlerts() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}