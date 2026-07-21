import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardData extends DashboardEvent {
  const LoadDashboardData();
}

class RefreshDashboard extends DashboardEvent {
  const RefreshDashboard();
}

// States
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final Map<String, dynamic> stats;
  final List<Map<String, dynamic>> recentActivity;
  final List<Map<String, dynamic>> alerts;

  const DashboardLoaded({
    required this.stats,
    required this.recentActivity,
    required this.alerts,
  });

  @override
  List<Object?> get props => [stats, recentActivity, alerts];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardInitial()) {
    on<LoadDashboardData>(_onLoadData);
    on<RefreshDashboard>(_onRefreshData);
  }

  Future<void> _onLoadData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());
    // TODO: Implement loading dashboard data
    emit(DashboardLoaded(
      stats: {
        'total_members': 256,
        'active_members': 198,
        'today_revenue': 2450.0,
        'today_attendance': 45,
      },
      recentActivity: [],
      alerts: [],
    ));
  }

  Future<void> _onRefreshData(
    RefreshDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    // TODO: Implement refreshing dashboard data
  }
}