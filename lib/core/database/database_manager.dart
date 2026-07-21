import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'schema/database_constants.dart';
import 'schema/database_schema.dart';
import 'migration_manager.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._();
  factory DatabaseManager() => _instance;
  DatabaseManager._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DatabaseConstants.databaseName);

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
      onConfigure: _onConfigure,
    );
  }

  Future<void> _onConfigure(Database db) async {
    // Enable foreign keys
    await db.execute('PRAGMA foreign_keys = ON');

    // Enable WAL mode for better performance
    await db.execute('PRAGMA journal_mode = WAL');

    // Set busy timeout
    await db.execute('PRAGMA busy_timeout = 5000');

    // Enable recursive triggers
    await db.execute('PRAGMA recursive_triggers = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create all tables
    await _createTables(db);

    // Create indexes
    await _createIndexes(db);

    // Insert seed data
    await _insertSeedData(db);
  }

  Future<void> _createTables(Database db) async {
    // Member Management Tables
    await db.execute(createMembersTable);
    await db.execute(createMemberPaymentsTable);
    await db.execute(createMemberHealthTable);

    // Workout & Training Tables
    await db.execute(createWorkoutProgramsTable);
    await db.execute(createExercisesTable);
    await db.execute(createWorkoutsTable);
    await db.execute(createWorkoutExercisesTable);
    await db.execute(createWorkoutLogsTable);
    await db.execute(createMemberProgressTable);

    // Trainer Management Tables
    await db.execute(createTrainersTable);
    await db.execute(createTrainerSchedulesTable);
    await db.execute(createTrainerAssignmentsTable);

    // Buffet Management Tables
    await db.execute(createCategoriesTable);
    await db.execute(createProductsTable);
    await db.execute(createInventoryTransactionsTable);
    await db.execute(createOrdersTable);
    await db.execute(createOrderItemsTable);

    // Accounting Tables
    await db.execute(createTransactionsTable);
    await db.execute(createInvoicesTable);
    await db.execute(createInvoiceItemsTable);
    await db.execute(createInstallmentPlansTable);

    // Attendance Table
    await db.execute(createAttendanceTable);

    // Staff Table
    await db.execute(createStaffTable);

    // Settings Table
    await db.execute(createSettingsTable);

    // Audit Log Table
    await db.execute(createAuditLogTable);
  }

  Future<void> _createIndexes(Database db) async {
    // All indexes are already created in the table creation scripts
    // This method is for any additional indexes that need to be created separately
  }

  Future<void> _insertSeedData(Database db) async {
    // Insert default categories
    await db.execute(seedCategories);

    // Insert default admin user
    await db.execute(seedDefaultAdmin);

    // Insert default settings
    await db.execute(seedDefaultSettings);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await MigrationManager.runMigrations(db, oldVersion, newVersion);
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int newVersion) async {
    // Handle database downgrade if needed
  }

  // ============================================================
  // DATABASE OPERATIONS
  // ============================================================

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DatabaseConstants.databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }

  Future<void> backupDatabase() async {
    // Implementation for database backup
  }

  Future<void> restoreDatabase(String backupPath) async {
    // Implementation for database restore
  }

  // ============================================================
  // GENERIC CRUD OPERATIONS
  // ============================================================

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    return await db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<Map<String, dynamic>?> queryById(String table, String id) async {
    final results = await query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<int> rawDelete(String sql, List<dynamic>? arguments) async {
    final db = await database;
    return await db.rawDelete(sql, arguments);
  }

  Future<List<Map<String, dynamic>>> rawQuery(String sql, List<dynamic>? arguments) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }

  Future<void> execute(String sql, [List<dynamic>? arguments]) async {
    final db = await database;
    await db.execute(sql, arguments);
  }

  // ============================================================
  // TRANSACTION SUPPORT
  // ============================================================

  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    final db = await database;
    return await db.transaction(action);
  }

  Future<void> batchInsert(String table, List<Map<String, dynamic>> data) async {
    final db = await database;
    final batch = db.batch();
    for (final item in data) {
      batch.insert(table, item, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  // ============================================================
  // MEMBER OPERATIONS
  // ============================================================

  Future<int> insertMember(Map<String, dynamic> member) async {
    return await insert(DatabaseConstants.membersTable, member);
  }

  Future<List<Map<String, dynamic>>> getAllMembers() async {
    return await query(
      DatabaseConstants.membersTable,
      where: 'is_active = 1',
      orderBy: 'created_at DESC',
    );
  }

  Future<Map<String, dynamic>?> getMemberById(String id) async {
    return await queryById(DatabaseConstants.membersTable, id);
  }

  Future<Map<String, dynamic>?> getMemberByPhone(String phone) async {
    final results = await query(
      DatabaseConstants.membersTable,
      where: 'phone = ?',
      whereArgs: [phone],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> updateMember(String id, Map<String, dynamic> data) async {
    return await update(
      DatabaseConstants.membersTable,
      {...data, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteMember(String id) async {
    return await update(
      DatabaseConstants.membersTable,
      {'is_active': 0, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> searchMembers(String query) async {
    return await rawQuery('''
      SELECT * FROM ${DatabaseConstants.membersTable}
      WHERE is_active = 1 AND (
        full_name LIKE ? OR
        phone LIKE ? OR
        email LIKE ? OR
        national_id LIKE ?
      )
      ORDER BY created_at DESC
    ''', ['%$query%', '%$query%', '%$query%', '%$query%']);
  }

  Future<List<Map<String, dynamic>>> getMembersByStatus(String status) async {
    return await query(
      DatabaseConstants.membersTable,
      where: 'membership_status = ? AND is_active = 1',
      whereArgs: [status],
      orderBy: 'membership_expiry_date ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getMembersExpiringSoon(int days) async {
    final expiryDate = DateTime.now().add(Duration(days: days)).toIso8601String();
    return await rawQuery('''
      SELECT * FROM ${DatabaseConstants.membersTable}
      WHERE is_active = 1
        AND membership_status = 'ACTIVE'
        AND membership_expiry_date <= ?
      ORDER BY membership_expiry_date ASC
    ''', [expiryDate]);
  }

  // ============================================================
  // PAYMENT OPERATIONS
  // ============================================================

  Future<int> insertPayment(Map<String, dynamic> payment) async {
    return await insert(DatabaseConstants.memberPaymentsTable, payment);
  }

  Future<List<Map<String, dynamic>>> getMemberPayments(String memberId) async {
    return await query(
      DatabaseConstants.memberPaymentsTable,
      where: 'member_id = ?',
      whereArgs: [memberId],
      orderBy: 'payment_date DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getPaymentsByStatus(String status) async {
    return await query(
      DatabaseConstants.memberPaymentsTable,
      where: 'payment_status = ?',
      whereArgs: [status],
      orderBy: 'payment_date DESC',
    );
  }

  Future<double> getMemberTotalPaid(String memberId) async {
    final result = await rawQuery('''
      SELECT COALESCE(SUM(amount), 0) as total_paid
      FROM ${DatabaseConstants.memberPaymentsTable}
      WHERE member_id = ? AND payment_status = 'PAID'
    ''', [memberId]);
    return (result.first['total_paid'] as num).toDouble();
  }

  // ============================================================
  // HEALTH OPERATIONS
  // ============================================================

  Future<int> insertHealthRecord(Map<String, dynamic> health) async {
    return await insert(DatabaseConstants.memberHealthTable, health);
  }

  Future<List<Map<String, dynamic>>> getMemberHealthHistory(String memberId) async {
    return await query(
      DatabaseConstants.memberHealthTable,
      where: 'member_id = ?',
      whereArgs: [memberId],
      orderBy: 'record_date DESC',
    );
  }

  Future<Map<String, dynamic>?> getLatestHealthRecord(String memberId) async {
    final results = await query(
      DatabaseConstants.memberHealthTable,
      where: 'member_id = ?',
      whereArgs: [memberId],
      orderBy: 'record_date DESC',
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  // ============================================================
  // WORKOUT OPERATIONS
  // ============================================================

  Future<int> insertWorkoutProgram(Map<String, dynamic> program) async {
    return await insert(DatabaseConstants.workoutProgramsTable, program);
  }

  Future<List<Map<String, dynamic>>> getAllPrograms() async {
    return await query(
      DatabaseConstants.workoutProgramsTable,
      where: 'is_active = 1',
      orderBy: 'created_at DESC',
    );
  }

  Future<int> insertExercise(Map<String, dynamic> exercise) async {
    return await insert(DatabaseConstants.exercisesTable, exercise);
  }

  Future<List<Map<String, dynamic>>> getAllExercises() async {
    return await query(
      DatabaseConstants.exercisesTable,
      where: 'is_active = 1',
      orderBy: 'name ASC',
    );
  }

  Future<int> insertWorkoutLog(Map<String, dynamic> log) async {
    return await insert(DatabaseConstants.workoutLogsTable, log);
  }

  Future<List<Map<String, dynamic>>> getMemberWorkoutLogs(String memberId) async {
    return await query(
      DatabaseConstants.workoutLogsTable,
      where: 'member_id = ?',
      whereArgs: [memberId],
      orderBy: 'log_date DESC',
    );
  }

  // ============================================================
  // TRAINER OPERATIONS
  // ============================================================

  Future<int> insertTrainer(Map<String, dynamic> trainer) async {
    return await insert(DatabaseConstants.trainersTable, trainer);
  }

  Future<List<Map<String, dynamic>>> getAllTrainers() async {
    return await query(
      DatabaseConstants.trainersTable,
      where: 'is_active = 1',
      orderBy: 'full_name ASC',
    );
  }

  Future<int> insertTrainerSchedule(Map<String, dynamic> schedule) async {
    return await insert(DatabaseConstants.trainerSchedulesTable, schedule);
  }

  Future<List<Map<String, dynamic>>> getTrainerSchedule(String trainerId) async {
    return await query(
      DatabaseConstants.trainerSchedulesTable,
      where: 'trainer_id = ?',
      whereArgs: [trainerId],
      orderBy: 'day_of_week ASC',
    );
  }

  // ============================================================
  // PRODUCT OPERATIONS
  // ============================================================

  Future<int> insertProduct(Map<String, dynamic> product) async {
    return await insert(DatabaseConstants.productsTable, product);
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    return await query(
      DatabaseConstants.productsTable,
      where: 'is_active = 1',
      orderBy: 'product_name ASC',
    );
  }

  Future<Map<String, dynamic>?> getProductByBarcode(String barcode) async {
    final results = await query(
      DatabaseConstants.productsTable,
      where: 'barcode = ?',
      whereArgs: [barcode],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Map<String, dynamic>>> getLowStockProducts() async {
    return await rawQuery('''
      SELECT * FROM ${DatabaseConstants.productsTable}
      WHERE is_active = 1 AND current_stock <= min_stock_level
      ORDER BY current_stock ASC
    ''');
  }

  // ============================================================
  // ORDER OPERATIONS
  // ============================================================

  Future<int> insertOrder(Map<String, dynamic> order) async {
    return await insert(DatabaseConstants.ordersTable, order);
  }

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    return await query(
      DatabaseConstants.ordersTable,
      orderBy: 'created_at DESC',
    );
  }

  Future<int> insertOrderItem(Map<String, dynamic> item) async {
    return await insert(DatabaseConstants.orderItemsTable, item);
  }

  Future<List<Map<String, dynamic>>> getOrderItems(String orderId) async {
    return await query(
      DatabaseConstants.orderItemsTable,
      where: 'order_id = ?',
      whereArgs: [orderId],
    );
  }

  // ============================================================
  // TRANSACTION OPERATIONS
  // ============================================================

  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    return await insert(DatabaseConstants.transactionsTable, transaction);
  }

  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    return await query(
      DatabaseConstants.transactionsTable,
      orderBy: 'transaction_date DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getTransactionsByType(String type) async {
    return await query(
      DatabaseConstants.transactionsTable,
      where: 'transaction_type = ?',
      whereArgs: [type],
      orderBy: 'transaction_date DESC',
    );
  }

  // ============================================================
  // ATTENDANCE OPERATIONS
  // ============================================================

  Future<int> insertAttendance(Map<String, dynamic> attendance) async {
    return await insert(DatabaseConstants.attendanceTable, attendance);
  }

  Future<List<Map<String, dynamic>>> getMemberAttendance(String memberId) async {
    return await query(
      DatabaseConstants.attendanceTable,
      where: 'member_id = ?',
      whereArgs: [memberId],
      orderBy: 'check_in_time DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getTodayAttendance() async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return await rawQuery('''
      SELECT * FROM ${DatabaseConstants.attendanceTable}
      WHERE DATE(check_in_time) = ?
      ORDER BY check_in_time DESC
    ''', [today]);
  }

  // ============================================================
  // STAFF OPERATIONS
  // ============================================================

  Future<int> insertStaff(Map<String, dynamic> staff) async {
    return await insert(DatabaseConstants.staffTable, staff);
  }

  Future<Map<String, dynamic>?> getStaffByUsername(String username) async {
    final results = await query(
      DatabaseConstants.staffTable,
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  // ============================================================
  // SETTINGS OPERATIONS
  // ============================================================

  Future<String?> getSetting(String key) async {
    final results = await query(
      DatabaseConstants.settingsTable,
      where: 'setting_key = ?',
      whereArgs: [key],
      limit: 1,
    );
    return results.isNotEmpty ? results.first['setting_value'] as String? : null;
  }

  Future<void> updateSetting(String key, String value) async {
    await update(
      DatabaseConstants.settingsTable,
      {'setting_value': value, 'updated_at': DateTime.now().toIso8601String()},
      where: 'setting_key = ?',
      whereArgs: [key],
    );
  }

  // ============================================================
  // REPORT QUERIES
  // ============================================================

  Future<Map<String, dynamic>> getDailySummary(DateTime date) async {
    final dateStr = date.toIso8601String().substring(0, 10);

    final attendanceCount = await rawQuery('''
      SELECT COUNT(*) as count FROM ${DatabaseConstants.attendanceTable}
      WHERE DATE(check_in_time) = ?
    ''', [dateStr]);

    final ordersSummary = await rawQuery('''
      SELECT COUNT(*) as order_count, COALESCE(SUM(total_price), 0) as total_sales
      FROM ${DatabaseConstants.ordersTable}
      WHERE DATE(created_at) = ?
    ''', [dateStr]);

    final paymentsSummary = await rawQuery('''
      SELECT COALESCE(SUM(amount), 0) as total_payments
      FROM ${DatabaseConstants.memberPaymentsTable}
      WHERE DATE(payment_date) = ?
    ''', [dateStr]);

    return {
      'date': dateStr,
      'attendance_count': attendanceCount.first['count'],
      'order_count': ordersSummary.first['order_count'],
      'total_sales': ordersSummary.first['total_sales'],
      'total_payments': paymentsSummary.first['total_payments'],
    };
  }

  Future<Map<String, dynamic>> getMonthlySummary(int year, int month) async {
    final startDate = DateTime(year, month, 1).toIso8601String().substring(0, 10);
    final endDate = DateTime(year, month + 1, 0).toIso8601String().substring(0, 10);

    final memberStats = await rawQuery('''
      SELECT
        COUNT(*) as total_members,
        SUM(CASE WHEN membership_status = 'ACTIVE' THEN 1 ELSE 0 END) as active_members
      FROM ${DatabaseConstants.membersTable}
      WHERE is_active = 1
    ''');

    final revenue = await rawQuery('''
      SELECT COALESCE(SUM(amount), 0) as total_revenue
      FROM ${DatabaseConstants.memberPaymentsTable}
      WHERE payment_date BETWEEN ? AND ?
        AND payment_status = 'PAID'
    ''', [startDate, endDate]);

    final expenses = await rawQuery('''
      SELECT COALESCE(SUM(amount), 0) as total_expenses
      FROM ${DatabaseConstants.transactionsTable}
      WHERE transaction_date BETWEEN ? AND ?
        AND transaction_type = 'EXPENSE'
    ''', [startDate, endDate]);

    return {
      'year': year,
      'month': month,
      'total_members': memberStats.first['total_members'],
      'active_members': memberStats.first['active_members'],
      'total_revenue': revenue.first['total_revenue'],
      'total_expenses': expenses.first['total_expenses'],
      'net_profit': (revenue.first['total_revenue'] as num) - (expenses.first['total_expenses'] as num),
    };
  }
}