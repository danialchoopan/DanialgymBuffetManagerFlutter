class RouteNames {
  RouteNames._();

  // Auth Routes
  static const String login = '/login';
  static const String setupWizard = '/setup-wizard';
  static const String biometricSetup = '/biometric-setup';

  // Dashboard Routes
  static const String adminDashboard = '/dashboard/admin';
  static const String trainerDashboard = '/dashboard/trainer';

  // Member Routes
  static const String memberList = '/members';
  static const String memberDetail = '/members/:id';
  static const String memberEdit = '/members/:id/edit';
  static const String memberPayment = '/members/:id/payments';
  static const String memberAdd = '/members/add';

  // Workout Routes
  static const String workoutProgramList = '/workouts';
  static const String workoutProgramDetail = '/workouts/:id';
  static const String workoutProgramCreate = '/workouts/create';
  static const String exerciseLibrary = '/exercises';
  static const String memberProgress = '/members/:id/progress';

  // Attendance Routes
  static const String attendanceList = '/attendance';
  static const String checkIn = '/attendance/check-in';
  static const String attendanceReport = '/attendance/report';

  // Buffet Routes
  static const String productList = '/buffet/products';
  static const String productDetail = '/buffet/products/:id';
  static const String productCreate = '/buffet/products/create';
  static const String orderList = '/buffet/orders';
  static const String orderDetail = '/buffet/orders/:id';
  static const String createOrder = '/buffet/orders/create';
  static const String inventory = '/buffet/inventory';

  // Accounting Routes
  static const String payments = '/accounting/payments';
  static const String transactions = '/accounting/transactions';
  static const String expenses = '/accounting/expenses';
  static const String reports = '/accounting/reports';
  static const String financialDashboard = '/accounting/dashboard';

  // Trainer Routes
  static const String trainerList = '/trainers';
  static const String trainerDetail = '/trainers/:id';
  static const String trainerSchedule = '/trainers/:id/schedule';

  // Settings Routes
  static const String settings = '/settings';
  static const String backup = '/settings/backup';
  static const String userManagement = '/settings/users';
  static const String appInfo = '/settings/about';

  // Helper methods
  static String memberDetailRoute(String id) => '/members/$id';
  static String memberEditRoute(String id) => '/members/$id/edit';
  static String memberPaymentRoute(String id) => '/members/$id/payments';
  static String memberProgressRoute(String id) => '/members/$id/progress';
  static String workoutDetailRoute(String id) => '/workouts/$id';
  static String productDetailRoute(String id) => '/buffet/products/$id';
  static String orderDetailRoute(String id) => '/buffet/orders/$id';
  static String trainerDetailRoute(String id) => '/trainers/$id';
  static String trainerScheduleRoute(String id) => '/trainers/$id/schedule';
}