// ============================================================
// TEST CONFIGURATION
// ============================================================
// This file contains test configuration, setup, and teardown
// for the Gym & Buffet Management test suite.
// ============================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// ============================================================
// TEST SETUP
// ============================================================

void setUpTestDatabase() {
  // Initialize FFI for desktop testing
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

Future<Database> createTestDatabase() async {
  return await databaseFactoryFfi.openDatabase(
    ':memory:',
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async {
        // Create test tables
        await _createTestTables(db);
      },
    ),
  );
}

Future<void> _createTestTables(Database db) async {
  // Members table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS members (
      id TEXT PRIMARY KEY,
      full_name TEXT NOT NULL,
      phone TEXT UNIQUE NOT NULL,
      email TEXT,
      gender TEXT,
      birth_date TEXT,
      membership_status TEXT DEFAULT 'ACTIVE',
      membership_type TEXT,
      membership_expiry_date TEXT,
      outstanding_balance REAL DEFAULT 0,
      total_paid REAL DEFAULT 0,
      total_visits INTEGER DEFAULT 0,
      is_active INTEGER DEFAULT 1,
      is_blocked INTEGER DEFAULT 0,
      created_at TEXT NOT NULL,
      updated_at TEXT
    )
  ''');

  // Payments table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS member_payments (
      id TEXT PRIMARY KEY,
      member_id TEXT NOT NULL,
      amount REAL NOT NULL,
      payment_date TEXT NOT NULL,
      payment_type TEXT,
      payment_method TEXT,
      payment_status TEXT,
      created_at TEXT NOT NULL,
      FOREIGN KEY (member_id) REFERENCES members(id)
    )
  ''');

  // Products table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS products (
      id TEXT PRIMARY KEY,
      product_name TEXT NOT NULL,
      barcode TEXT UNIQUE,
      category_id TEXT,
      selling_price REAL NOT NULL,
      cost_price REAL,
      current_stock REAL DEFAULT 0,
      min_stock_level REAL DEFAULT 10,
      max_stock_level REAL DEFAULT 100,
      unit TEXT DEFAULT 'PIECE',
      is_active INTEGER DEFAULT 1,
      created_at TEXT NOT NULL,
      updated_at TEXT
    )
  ''');

  // Orders table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS orders (
      id TEXT PRIMARY KEY,
      order_number TEXT UNIQUE NOT NULL,
      member_id TEXT,
      subtotal REAL NOT NULL,
      discount_amount REAL DEFAULT 0,
      tax_amount REAL DEFAULT 0,
      total_price REAL NOT NULL,
      order_status TEXT DEFAULT 'PENDING',
      payment_status TEXT DEFAULT 'UNPAID',
      created_at TEXT NOT NULL,
      updated_at TEXT,
      FOREIGN KEY (member_id) REFERENCES members(id)
    )
  ''');

  // Order items table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS order_items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      order_id TEXT NOT NULL,
      product_id TEXT NOT NULL,
      product_name TEXT NOT NULL,
      quantity INTEGER NOT NULL,
      unit_price REAL NOT NULL,
      total_price REAL NOT NULL,
      FOREIGN KEY (order_id) REFERENCES orders(id),
      FOREIGN KEY (product_id) REFERENCES products(id)
    )
  ''');

  // Transactions table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS transactions (
      id TEXT PRIMARY KEY,
      transaction_number TEXT UNIQUE NOT NULL,
      transaction_type TEXT NOT NULL,
      category TEXT NOT NULL,
      amount REAL NOT NULL,
      description TEXT,
      transaction_date TEXT NOT NULL,
      created_at TEXT NOT NULL
    )
  ''');

  // Attendance table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS attendance (
      id TEXT PRIMARY KEY,
      member_id TEXT NOT NULL,
      member_name TEXT NOT NULL,
      check_in_time TEXT NOT NULL,
      check_out_time TEXT,
      duration_minutes INTEGER,
      check_in_method TEXT DEFAULT 'MANUAL',
      created_at TEXT NOT NULL,
      FOREIGN KEY (member_id) REFERENCES members(id)
    )
  ''');

  // Staff table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS staff (
      id TEXT PRIMARY KEY,
      full_name TEXT NOT NULL,
      phone TEXT UNIQUE NOT NULL,
      role TEXT NOT NULL,
      username TEXT UNIQUE NOT NULL,
      password_hash TEXT NOT NULL,
      is_active INTEGER DEFAULT 1,
      created_at TEXT NOT NULL,
      updated_at TEXT
    )
  ''');

  // Settings table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS settings (
      id TEXT PRIMARY KEY,
      setting_key TEXT UNIQUE NOT NULL,
      setting_value TEXT,
      setting_type TEXT DEFAULT 'STRING',
      created_at TEXT NOT NULL,
      updated_at TEXT
    )
  ''');
}

// ============================================================
// TEST DATA INSERTION
// ============================================================

Future<void> insertTestData(Database db) async {
  // Insert test members
  await db.insert('members', {
    'id': 'MEM001',
    'full_name': 'علی محمدی',
    'phone': '09123456789',
    'email': 'ali@example.com',
    'gender': 'MALE',
    'birth_date': '1990-01-15',
    'membership_status': 'ACTIVE',
    'membership_type': 'MONTHLY',
    'membership_expiry_date': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
    'outstanding_balance': 0,
    'total_paid': 500000,
    'total_visits': 25,
    'is_active': 1,
    'is_blocked': 0,
    'created_at': DateTime.now().toIso8601String(),
  });

  await db.insert('members', {
    'id': 'MEM002',
    'full_name': 'رضا احمدی',
    'phone': '09123456790',
    'email': 'reza@example.com',
    'gender': 'MALE',
    'birth_date': '1985-05-20',
    'membership_status': 'EXPIRED',
    'membership_type': 'QUARTERLY',
    'membership_expiry_date': DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
    'outstanding_balance': 200000,
    'total_paid': 300000,
    'total_visits': 45,
    'is_active': 1,
    'is_blocked': 0,
    'created_at': DateTime.now().toIso8601String(),
  });

  // Insert test products
  await db.insert('products', {
    'id': 'PROD001',
    'product_name': 'پروتئین شیک',
    'barcode': '123456789012',
    'category_id': 'CAT001',
    'selling_price': 150000,
    'cost_price': 100000,
    'current_stock': 50,
    'min_stock_level': 10,
    'max_stock_level': 100,
    'unit': 'PIECE',
    'is_active': 1,
    'created_at': DateTime.now().toIso8601String(),
  });

  await db.insert('products', {
    'id': 'PROD002',
    'product_name': 'آب معدنی',
    'barcode': '123456789013',
    'category_id': 'CAT002',
    'selling_price': 10000,
    'cost_price': 5000,
    'current_stock': 5,
    'min_stock_level': 10,
    'max_stock_level': 100,
    'unit': 'BOTTLE',
    'is_active': 1,
    'created_at': DateTime.now().toIso8601String(),
  });

  // Insert test staff
  await db.insert('staff', {
    'id': 'STAFF001',
    'full_name': 'مدیر سیستم',
    'phone': '0000000000',
    'role': 'ADMIN',
    'username': 'admin',
    'password_hash': 'hashed_password_here',
    'is_active': 1,
    'created_at': DateTime.now().toIso8601String(),
  });
}

// ============================================================
// TEST CLEANUP
// ============================================================

Future<void> cleanupTestDatabase(Database db) async {
  // Delete all test data
  await db.delete('members');
  await db.delete('member_payments');
  await db.delete('products');
  await db.delete('orders');
  await db.delete('order_items');
  await db.delete('transactions');
  await db.delete('attendance');
  await db.delete('staff');
  await db.delete('settings');
}

// ============================================================
// TEST ASSERTIONS
// ============================================================

class TestAssertions {
  TestAssertions._();

  static void assertValidMember(Map<String, dynamic> member) {
    expect(member['id'], isNotEmpty);
    expect(member['full_name'], isNotEmpty);
    expect(member['phone'], isNotEmpty);
    expect(member['phone'].toString().length, equals(11));
    expect(member['phone'].toString().startsWith('09'), isTrue);
    expect(member['membership_status'], isNotEmpty);
  }

  static void assertValidPayment(Map<String, dynamic> payment) {
    expect(payment['id'], isNotEmpty);
    expect(payment['member_id'], isNotEmpty);
    expect(payment['amount'], greaterThan(0));
    expect(payment['payment_date'], isNotEmpty);
    expect(payment['payment_status'], isNotEmpty);
  }

  static void assertValidOrder(Map<String, dynamic> order) {
    expect(order['id'], isNotEmpty);
    expect(order['order_number'], isNotEmpty);
    expect(order['subtotal'], greaterThan(0));
    expect(order['total_price'], greaterThan(0));
    expect(order['order_status'], isNotEmpty);
  }

  static void assertValidProduct(Map<String, dynamic> product) {
    expect(product['id'], isNotEmpty);
    expect(product['product_name'], isNotEmpty);
    expect(product['selling_price'], greaterThan(0));
    expect(product['current_stock'], greaterThanOrEqualTo(0));
  }

  static void assertMembershipActive(Map<String, dynamic> member) {
    expect(member['membership_status'], equals('ACTIVE'));
    expect(member['is_active'], equals(1));
    expect(member['is_blocked'], equals(0));
  }

  static void assertMembershipExpired(Map<String, dynamic> member) {
    expect(member['membership_status'], equals('EXPIRED'));
  }

  static void assertStockLow(Map<String, dynamic> product) {
    expect(
      product['current_stock'],
      lessThanOrEqualTo(product['min_stock_level']),
    );
  }

  static void assertStockOut(Map<String, dynamic> product) {
    expect(product['current_stock'], equals(0));
  }
}

// ============================================================
// PERFORMANCE TEST HELPERS
// ============================================================

class PerformanceHelpers {
  PerformanceHelpers._();

  static Future<void> benchmarkOperation(
    String name,
    Future<void> Function() operation, {
    int iterations = 100,
  }) async {
    final stopwatch = Stopwatch()..start();

    for (var i = 0; i < iterations; i++) {
      await operation();
    }

    stopwatch.stop();
    final avgTime = stopwatch.elapsedMilliseconds / iterations;

    print('$name: ${stopwatch.elapsedMilliseconds}ms total, ${avgTime}ms avg');
  }

  static void assertPerformance({
    required String operation,
    required Duration elapsed,
    required Duration maxAllowed,
  }) {
    if (elapsed > maxAllowed) {
      fail(
        '$operation took ${elapsed.inMilliseconds}ms, '
        'exceeding max allowed ${maxAllowed.inMilliseconds}ms',
      );
    }
  }
}