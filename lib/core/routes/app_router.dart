import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import 'route_guards.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._();
  factory AppRouter() => _instance;
  AppRouter._();

  final RouteGuards _guards = RouteGuards();
  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: _guards.isAuthenticated ? RouteNames.adminDashboard : RouteNames.login,
    redirect: (context, state) {
      final isLoggedIn = _guards.isAuthenticated;
      final isLoginRoute = state.matchedLocation == RouteNames.login;

      if (!isLoggedIn && !isLoginRoute) {
        return RouteNames.login;
      }

      if (isLoggedIn && isLoginRoute) {
        return RouteNames.adminDashboard;
      }

      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Login Page')),
        ),
      ),
      GoRoute(
        path: RouteNames.setupWizard,
        name: 'setup-wizard',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Setup Wizard')),
        ),
      ),
      GoRoute(
        path: RouteNames.biometricSetup,
        name: 'biometric-setup',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Biometric Setup')),
        ),
      ),

      // Dashboard Routes
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ScaffoldWithNavBar(child: child),
        routes: [
          GoRoute(
            path: RouteNames.adminDashboard,
            name: 'admin-dashboard',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Admin Dashboard')),
            ),
          ),
          GoRoute(
            path: RouteNames.memberList,
            name: 'member-list',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Member List')),
            ),
          ),
          GoRoute(
            path: RouteNames.workoutProgramList,
            name: 'workout-list',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Workout Programs')),
            ),
          ),
          GoRoute(
            path: RouteNames.inventory,
            name: 'inventory',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Inventory')),
            ),
          ),
          GoRoute(
            path: RouteNames.reports,
            name: 'reports',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Reports')),
            ),
          ),
        ],
      ),

      // Member Routes
      GoRoute(
        path: '/members/:id',
        name: 'member-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Scaffold(
            body: Center(child: Text('Member Detail: $id')),
          );
        },
      ),
      GoRoute(
        path: '/members/:id/edit',
        name: 'member-edit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Scaffold(
            body: Center(child: Text('Edit Member: $id')),
          );
        },
      ),
      GoRoute(
        path: '/members/:id/payments',
        name: 'member-payment',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Scaffold(
            body: Center(child: Text('Member Payments: $id')),
          );
        },
      ),
      GoRoute(
        path: '/members/add',
        name: 'member-add',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Add Member')),
        ),
      ),

      // Workout Routes
      GoRoute(
        path: '/workouts/:id',
        name: 'workout-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Scaffold(
            body: Center(child: Text('Workout Detail: $id')),
          );
        },
      ),
      GoRoute(
        path: '/workouts/create',
        name: 'workout-create',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Create Workout')),
        ),
      ),
      GoRoute(
        path: '/exercises',
        name: 'exercise-library',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Exercise Library')),
        ),
      ),
      GoRoute(
        path: '/members/:id/progress',
        name: 'member-progress',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Scaffold(
            body: Center(child: Text('Member Progress: $id')),
          );
        },
      ),

      // Attendance Routes
      GoRoute(
        path: '/attendance',
        name: 'attendance-list',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Attendance List')),
        ),
      ),
      GoRoute(
        path: '/attendance/check-in',
        name: 'check-in',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Check In')),
        ),
      ),
      GoRoute(
        path: '/attendance/report',
        name: 'attendance-report',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Attendance Report')),
        ),
      ),

      // Buffet Routes
      GoRoute(
        path: '/buffet/products',
        name: 'product-list',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Products')),
        ),
      ),
      GoRoute(
        path: '/buffet/products/:id',
        name: 'product-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Scaffold(
            body: Center(child: Text('Product Detail: $id')),
          );
        },
      ),
      GoRoute(
        path: '/buffet/products/create',
        name: 'product-create',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Create Product')),
        ),
      ),
      GoRoute(
        path: '/buffet/orders',
        name: 'order-list',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Orders')),
        ),
      ),
      GoRoute(
        path: '/buffet/orders/:id',
        name: 'order-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Scaffold(
            body: Center(child: Text('Order Detail: $id')),
          );
        },
      ),
      GoRoute(
        path: '/buffet/orders/create',
        name: 'create-order',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Create Order')),
        ),
      ),

      // Accounting Routes
      GoRoute(
        path: '/accounting/payments',
        name: 'payments',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Payments')),
        ),
      ),
      GoRoute(
        path: '/accounting/transactions',
        name: 'transactions',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Transactions')),
        ),
      ),
      GoRoute(
        path: '/accounting/expenses',
        name: 'expenses',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Expenses')),
        ),
      ),
      GoRoute(
        path: '/accounting/dashboard',
        name: 'financial-dashboard',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Financial Dashboard')),
        ),
      ),

      // Trainer Routes
      GoRoute(
        path: '/trainers',
        name: 'trainer-list',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Trainers')),
        ),
      ),
      GoRoute(
        path: '/trainers/:id',
        name: 'trainer-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Scaffold(
            body: Center(child: Text('Trainer Detail: $id')),
          );
        },
      ),
      GoRoute(
        path: '/trainers/:id/schedule',
        name: 'trainer-schedule',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Scaffold(
            body: Center(child: Text('Trainer Schedule: $id')),
          );
        },
      ),

      // Settings Routes
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Settings')),
        ),
      ),
      GoRoute(
        path: '/settings/backup',
        name: 'backup',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Backup')),
        ),
      ),
      GoRoute(
        path: '/settings/users',
        name: 'user-management',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('User Management')),
        ),
      ),
      GoRoute(
        path: '/settings/about',
        name: 'app-info',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('About')),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(state.matchedLocation),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.adminDashboard),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Buffet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Reports',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/members')) return 1;
    if (location.startsWith('/workouts')) return 2;
    if (location.startsWith('/buffet')) return 3;
    if (location.startsWith('/accounting') || location.startsWith('/reports')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(RouteNames.adminDashboard);
        break;
      case 1:
        context.go(RouteNames.memberList);
        break;
      case 2:
        context.go(RouteNames.workoutProgramList);
        break;
      case 3:
        context.go(RouteNames.inventory);
        break;
      case 4:
        context.go(RouteNames.reports);
        break;
    }
  }
}