import 'package:floor/floor.dart';

// ============================================================
// DATABASE CONSTANTS
// ============================================================

class DatabaseConstants {
  DatabaseConstants._();

  static const String databaseName = 'gym_buffet_manager.db';
  static const int databaseVersion = 1;

  // Table Names
  static const String membersTable = 'members';
  static const String memberPaymentsTable = 'member_payments';
  static const String memberHealthTable = 'member_health';
  static const String workoutProgramsTable = 'workout_programs';
  static const String exercisesTable = 'exercises';
  static const String workoutsTable = 'workouts';
  static const String workoutExercisesTable = 'workout_exercises';
  static const String workoutLogsTable = 'workout_logs';
  static const String memberProgressTable = 'member_progress';
  static const String trainersTable = 'trainers';
  static const String trainerSchedulesTable = 'trainer_schedules';
  static const String trainerAssignmentsTable = 'trainer_assignments';
  static const String categoriesTable = 'categories';
  static const String productsTable = 'products';
  static const String inventoryTransactionsTable = 'inventory_transactions';
  static const String ordersTable = 'orders';
  static const String orderItemsTable = 'order_items';
  static const String transactionsTable = 'transactions';
  static const String invoicesTable = 'invoices';
  static const String invoiceItemsTable = 'invoice_items';
  static const String installmentPlansTable = 'installment_plans';
  static const String attendanceTable = 'attendance';
  static const String staffTable = 'staff';
  static const String settingsTable = 'settings';
  static const String auditLogTable = 'audit_log';

  // Common Columns
  static const String idColumn = 'id';
  static const String createdAtColumn = 'created_at';
  static const String updatedAtColumn = 'updated_at';
  static const String isActiveColumn = 'is_active';
}