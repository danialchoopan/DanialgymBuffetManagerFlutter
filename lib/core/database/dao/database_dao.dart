import 'package:sqflite/sqflite.dart';
import '../database_manager.dart';
import '../schema/database_constants.dart';

// ============================================================
// MEMBER DAO
// ============================================================

class MemberDao {
  final DatabaseManager _db = DatabaseManager();

  Future<int> insert(Map<String, dynamic> member) async {
    return await _db.insert(DatabaseConstants.membersTable, member);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await _db.query(
      DatabaseConstants.membersTable,
      where: 'is_active = 1',
      orderBy: 'created_at DESC',
    );
  }

  Future<Map<String, dynamic>?> getById(String id) async {
    return await _db.queryById(DatabaseConstants.membersTable, id);
  }

  Future<Map<String, dynamic>?> getByPhone(String phone) async {
    final results = await _db.query(
      DatabaseConstants.membersTable,
      where: 'phone = ?',
      whereArgs: [phone],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> update(String id, Map<String, dynamic> data) async {
    return await _db.update(
      DatabaseConstants.membersTable,
      {...data, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(String id) async {
    return await _db.update(
      DatabaseConstants.membersTable,
      {'is_active': 0, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> search(String query) async {
    return await _db.rawQuery('''
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

  Future<List<Map<String, dynamic>>> getByStatus(String status) async {
    return await _db.query(
      DatabaseConstants.membersTable,
      where: 'membership_status = ? AND is_active = 1',
      whereArgs: [status],
      orderBy: 'membership_expiry_date ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getExpiringSoon(int days) async {
    final expiryDate = DateTime.now().add(Duration(days: days)).toIso8601String();
    return await _db.rawQuery('''
      SELECT * FROM ${DatabaseConstants.membersTable}
      WHERE is_active = 1
        AND membership_status = 'ACTIVE'
        AND membership_expiry_date <= ?
      ORDER BY membership_expiry_date ASC
    ''', [expiryDate]);
  }

  Future<int> updateMembershipStatus(String id, String status) async {
    return await _db.update(
      DatabaseConstants.membersTable,
      {
        'membership_status': status,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> incrementVisits(String id) async {
    return await _db.rawUpdate('''
      UPDATE ${DatabaseConstants.membersTable}
      SET total_visits = total_visits + 1,
          last_visit_date = ?,
          updated_at = ?
      WHERE id = ?
    ''', [DateTime.now().toIso8601String(), DateTime.now().toIso8601String(), id]);
  }
}

// ============================================================
// PAYMENT DAO
// ============================================================

class PaymentDao {
  final DatabaseManager _db = DatabaseManager();

  Future<int> insert(Map<String, dynamic> payment) async {
    return await _db.insert(DatabaseConstants.memberPaymentsTable, payment);
  }

  Future<List<Map<String, dynamic>>> getByMemberId(String memberId) async {
    return await _db.query(
      DatabaseConstants.memberPaymentsTable,
      where: 'member_id = ?',
      whereArgs: [memberId],
      orderBy: 'payment_date DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getByStatus(String status) async {
    return await _db.query(
      DatabaseConstants.memberPaymentsTable,
      where: 'payment_status = ?',
      whereArgs: [status],
      orderBy: 'payment_date DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return await _db.query(
      DatabaseConstants.memberPaymentsTable,
      where: 'payment_date BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'payment_date DESC',
    );
  }

  Future<double> getTotalPaidByMember(String memberId) async {
    final result = await _db.rawQuery('''
      SELECT COALESCE(SUM(amount), 0) as total_paid
      FROM ${DatabaseConstants.memberPaymentsTable}
      WHERE member_id = ? AND payment_status = 'PAID'
    ''', [memberId]);
    return (result.first['total_paid'] as num).toDouble();
  }

  Future<double> getOutstandingBalance(String memberId) async {
    final result = await _db.rawQuery('''
      SELECT COALESCE(SUM(remaining_amount), 0) as balance
      FROM ${DatabaseConstants.memberPaymentsTable}
      WHERE member_id = ? AND payment_status != 'PAID'
    ''', [memberId]);
    return (result.first['balance'] as num).toDouble();
  }
}

// ============================================================
// HEALTH DAO
// ============================================================

class HealthDao {
  final DatabaseManager _db = DatabaseManager();

  Future<int> insert(Map<String, dynamic> health) async {
    return await _db.insert(DatabaseConstants.memberHealthTable, health);
  }

  Future<List<Map<String, dynamic>>> getByMemberId(String memberId) async {
    return await _db.query(
      DatabaseConstants.memberHealthTable,
      where: 'member_id = ?',
      whereArgs: [memberId],
      orderBy: 'record_date DESC',
    );
  }

  Future<Map<String, dynamic>?> getLatest(String memberId) async {
    final results = await _db.query(
      DatabaseConstants.memberHealthTable,
      where: 'member_id = ?',
      whereArgs: [memberId],
      orderBy: 'record_date DESC',
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> update(String id, Map<String, dynamic> data) async {
    return await _db.update(
      DatabaseConstants.memberHealthTable,
      {...data, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// ============================================================
// EXERCISE DAO
// ============================================================

class ExerciseDao {
  final DatabaseManager _db = DatabaseManager();

  Future<int> insert(Map<String, dynamic> exercise) async {
    return await _db.insert(DatabaseConstants.exercisesTable, exercise);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await _db.query(
      DatabaseConstants.exercisesTable,
      where: 'is_active = 1',
      orderBy: 'name ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getByCategory(String category) async {
    return await _db.query(
      DatabaseConstants.exercisesTable,
      where: 'exercise_category = ? AND is_active = 1',
      whereArgs: [category],
      orderBy: 'name ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getByMuscleGroup(String muscleGroup) async {
    return await _db.query(
      DatabaseConstants.exercisesTable,
      where: 'primary_muscle = ? AND is_active = 1',
      whereArgs: [muscleGroup],
      orderBy: 'name ASC',
    );
  }

  Future<List<Map<String, dynamic>>> search(String query) async {
    return await _db.rawQuery('''
      SELECT * FROM ${DatabaseConstants.exercisesTable}
      WHERE is_active = 1 AND (
        name LIKE ? OR
        description LIKE ? OR
        primary_muscle LIKE ?
      )
      ORDER BY name ASC
    ''', ['%$query%', '%$query%', '%$query%']);
  }
}

// ============================================================
// PRODUCT DAO
// ============================================================

class ProductDao {
  final DatabaseManager _db = DatabaseManager();

  Future<int> insert(Map<String, dynamic> product) async {
    return await _db.insert(DatabaseConstants.productsTable, product);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await _db.query(
      DatabaseConstants.productsTable,
      where: 'is_active = 1',
      orderBy: 'product_name ASC',
    );
  }

  Future<Map<String, dynamic>?> getById(String id) async {
    return await _db.queryById(DatabaseConstants.productsTable, id);
  }

  Future<Map<String, dynamic>?> getByBarcode(String barcode) async {
    final results = await _db.query(
      DatabaseConstants.productsTable,
      where: 'barcode = ?',
      whereArgs: [barcode],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Map<String, dynamic>>> getLowStock() async {
    return await _db.rawQuery('''
      SELECT * FROM ${DatabaseConstants.productsTable}
      WHERE is_active = 1 AND current_stock <= min_stock_level
      ORDER BY current_stock ASC
    ''');
  }

  Future<int> updateStock(String id, double newQuantity) async {
    return await _db.update(
      DatabaseConstants.productsTable,
      {
        'current_stock': newQuantity,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(String id, Map<String, dynamic> data) async {
    return await _db.update(
      DatabaseConstants.productsTable,
      {...data, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// ============================================================
// ORDER DAO
// ============================================================

class OrderDao {
  final DatabaseManager _db = DatabaseManager();

  Future<int> insert(Map<String, dynamic> order) async {
    return await _db.insert(DatabaseConstants.ordersTable, order);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await _db.query(
      DatabaseConstants.ordersTable,
      orderBy: 'created_at DESC',
    );
  }

  Future<Map<String, dynamic>?> getById(String id) async {
    return await _db.queryById(DatabaseConstants.ordersTable, id);
  }

  Future<List<Map<String, dynamic>>> getByDate(DateTime date) async {
    final dateStr = date.toIso8601String().substring(0, 10);
    return await _db.rawQuery('''
      SELECT * FROM ${DatabaseConstants.ordersTable}
      WHERE DATE(created_at) = ?
      ORDER BY created_at DESC
    ''', [dateStr]);
  }

  Future<int> updateStatus(String id, String status) async {
    final updates = {
      'order_status': status,
      'updated_at': DateTime.now().toIso8601String(),
    };
    if (status == 'COMPLETED') {
      updates['completed_at'] = DateTime.now().toIso8601String();
    }
    return await _db.update(
      DatabaseConstants.ordersTable,
      updates,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    return await _db.insert(DatabaseConstants.orderItemsTable, item);
  }

  Future<List<Map<String, dynamic>>> getItems(String orderId) async {
    return await _db.query(
      DatabaseConstants.orderItemsTable,
      where: 'order_id = ?',
      whereArgs: [orderId],
    );
  }
}

// ============================================================
// TRANSACTION DAO
// ============================================================

class TransactionDao {
  final DatabaseManager _db = DatabaseManager();

  Future<int> insert(Map<String, dynamic> transaction) async {
    return await _db.insert(DatabaseConstants.transactionsTable, transaction);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await _db.query(
      DatabaseConstants.transactionsTable,
      orderBy: 'transaction_date DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getByType(String type) async {
    return await _db.query(
      DatabaseConstants.transactionsTable,
      where: 'transaction_type = ?',
      whereArgs: [type],
      orderBy: 'transaction_date DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return await _db.query(
      DatabaseConstants.transactionsTable,
      where: 'transaction_date BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'transaction_date DESC',
    );
  }

  Future<double> getTotalByTypeAndDateRange(
    String type,
    DateTime start,
    DateTime end,
  ) async {
    final result = await _db.rawQuery('''
      SELECT COALESCE(SUM(amount), 0) as total
      FROM ${DatabaseConstants.transactionsTable}
      WHERE transaction_type = ?
        AND transaction_date BETWEEN ? AND ?
    ''', [type, start.toIso8601String(), end.toIso8601String()]);
    return (result.first['total'] as num).toDouble();
  }
}

// ============================================================
// ATTENDANCE DAO
// ============================================================

class AttendanceDao {
  final DatabaseManager _db = DatabaseManager();

  Future<int> insert(Map<String, dynamic> attendance) async {
    return await _db.insert(DatabaseConstants.attendanceTable, attendance);
  }

  Future<List<Map<String, dynamic>>> getByMemberId(String memberId) async {
    return await _db.query(
      DatabaseConstants.attendanceTable,
      where: 'member_id = ?',
      whereArgs: [memberId],
      orderBy: 'check_in_time DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getByDate(DateTime date) async {
    final dateStr = date.toIso8601String().substring(0, 10);
    return await _db.rawQuery('''
      SELECT * FROM ${DatabaseConstants.attendanceTable}
      WHERE DATE(check_in_time) = ?
      ORDER BY check_in_time DESC
    ''', [dateStr]);
  }

  Future<int> updateCheckOut(String id, DateTime checkOutTime, int durationMinutes) async {
    return await _db.update(
      DatabaseConstants.attendanceTable,
      {
        'check_out_time': checkOutTime.toIso8601String(),
        'duration_minutes': durationMinutes,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isAlreadyCheckedIn(String memberId) async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final results = await _db.rawQuery('''
      SELECT COUNT(*) as count FROM ${DatabaseConstants.attendanceTable}
      WHERE member_id = ? AND DATE(check_in_time) = ? AND check_out_time IS NULL
    ''', [memberId, today]);
    return (results.first['count'] as int) > 0;
  }

  Future<Map<String, dynamic>?> getActiveSession(String memberId) async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final results = await _db.rawQuery('''
      SELECT * FROM ${DatabaseConstants.attendanceTable}
      WHERE member_id = ? AND DATE(check_in_time) = ? AND check_out_time IS NULL
      LIMIT 1
    ''', [memberId, today]);
    return results.isNotEmpty ? results.first : null;
  }
}

// ============================================================
// STAFF DAO
// ============================================================

class StaffDao {
  final DatabaseManager _db = DatabaseManager();

  Future<int> insert(Map<String, dynamic> staff) async {
    return await _db.insert(DatabaseConstants.staffTable, staff);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await _db.query(
      DatabaseConstants.staffTable,
      where: 'is_active = 1',
      orderBy: 'full_name ASC',
    );
  }

  Future<Map<String, dynamic>?> getById(String id) async {
    return await _db.queryById(DatabaseConstants.staffTable, id);
  }

  Future<Map<String, dynamic>?> getByUsername(String username) async {
    final results = await _db.query(
      DatabaseConstants.staffTable,
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> update(String id, Map<String, dynamic> data) async {
    return await _db.update(
      DatabaseConstants.staffTable,
      {...data, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// ============================================================
// SETTINGS DAO
// ============================================================

class SettingsDao {
  final DatabaseManager _db = DatabaseManager();

  Future<String?> get(String key) async {
    final results = await _db.query(
      DatabaseConstants.settingsTable,
      where: 'setting_key = ?',
      whereArgs: [key],
      limit: 1,
    );
    return results.isNotEmpty ? results.first['setting_value'] as String? : null;
  }

  Future<void> set(String key, String value) async {
    final existing = await get(key);
    if (existing != null) {
      await _db.update(
        DatabaseConstants.settingsTable,
        {'setting_value': value, 'updated_at': DateTime.now().toIso8601String()},
        where: 'setting_key = ?',
        whereArgs: [key],
      );
    } else {
      await _db.insert(DatabaseConstants.settingsTable, {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'setting_key': key,
        'setting_value': value,
        'setting_type': 'STRING',
        'created_at': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<Map<String, String>> getAll() async {
    final results = await _db.query(DatabaseConstants.settingsTable);
    return {
      for (final row in results)
        row['setting_key'] as String: row['setting_value'] as String? ?? '',
    };
  }
}