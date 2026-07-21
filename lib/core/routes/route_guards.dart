import 'package:flutter/material.dart';

class RouteGuards {
  static final RouteGuards _instance = RouteGuards._();
  factory RouteGuards() => _instance;
  RouteGuards._();

  bool _isAuthenticated = false;
  String _currentRole = '';
  String _currentUserId = '';

  bool get isAuthenticated => _isAuthenticated;
  String get currentRole => _currentRole;
  String get currentUserId => _currentUserId;

  void setAuthenticated(bool value) {
    _isAuthenticated = value;
  }

  void setCurrentRole(String role) {
    _currentRole = role;
  }

  void setCurrentUserId(String userId) {
    _currentUserId = userId;
  }

  void login(String userId, String role) {
    _isAuthenticated = true;
    _currentUserId = userId;
    _currentRole = role;
  }

  void logout() {
    _isAuthenticated = false;
    _currentUserId = '';
    _currentRole = '';
  }

  bool hasPermission(String permission) {
    if (!_isAuthenticated) return false;

    const rolePermissions = {
      'admin': [
        'manage_members',
        'manage_trainers',
        'manage_staff',
        'manage_workouts',
        'manage_buffet',
        'manage_accounting',
        'view_reports',
        'manage_settings',
        'manage_backup',
      ],
      'trainer': [
        'view_members',
        'manage_workouts',
        'track_progress',
        'view_schedule',
      ],
      'accountant': [
        'view_members',
        'manage_accounting',
        'view_reports',
        'manage_transactions',
      ],
      'receptionist': [
        'manage_members',
        'manage_attendance',
        'manage_payments',
        'view_members',
      ],
      'staff': [
        'view_members',
        'manage_buffet',
        'manage_inventory',
      ],
    };

    final permissions = rolePermissions[_currentRole] ?? [];
    return permissions.contains(permission);
  }

  bool canAccessDashboard() {
    return _isAuthenticated && (_currentRole == 'admin' || _currentRole == 'trainer');
  }

  bool canManageMembers() {
    return hasPermission('manage_members');
  }

  bool canManageWorkouts() {
    return hasPermission('manage_workouts');
  }

  bool canManageBuffet() {
    return hasPermission('manage_buffet');
  }

  bool canManageAccounting() {
    return hasPermission('manage_accounting');
  }

  bool canManageStaff() {
    return hasPermission('manage_staff');
  }

  bool canViewReports() {
    return hasPermission('view_reports');
  }

  bool canManageSettings() {
    return hasPermission('manage_settings');
  }

  Widget guard(Widget child, {String? requiredPermission}) {
    if (!_isAuthenticated) {
      return const UnauthorizedWidget();
    }

    if (requiredPermission != null && !hasPermission(requiredPermission)) {
      return const UnauthorizedWidget(
        message: 'You do not have permission to access this feature.',
      );
    }

    return child;
  }
}

class UnauthorizedWidget extends StatelessWidget {
  final String message;

  const UnauthorizedWidget({
    super.key,
    this.message = 'Please log in to access this feature.',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unauthorized'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}