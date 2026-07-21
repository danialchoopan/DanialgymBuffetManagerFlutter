import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// MOCK CLASSES
// ============================================================

// Mock Repository
class MockMemberRepository extends Mock implements MemberRepository {}
class MockWorkoutRepository extends Mock implements WorkoutRepository {}
class MockAttendanceRepository implements AttendanceRepository {
  @override
  Future<List<Map<String, dynamic>>> getAll() async => [];
  @override
  Future<Map<String, dynamic>?> getById(String id) async => null;
  @override
  Future<int> insert(Map<String, dynamic> data) async => 1;
  @override
  Future<int> update(String id, Map<String, dynamic> data) async => 1;
  @override
  Future<int> delete(String id) async => 1;
}

// Mock Services
class MockDatabaseService extends Mock implements DatabaseService {}
class MockNotificationService extends Mock implements NotificationService {}
class MockBackupService extends Mock implements BackupService {}
class MockExportService extends Mock implements ExportService {}
class MockAuthService extends Mock implements AuthService {}

// Mock Entities
class MockMember extends Mock implements MemberEntity {}
class MockPayment extends Mock implements MemberPaymentEntity {}
class MockOrder extends Mock implements OrderEntity {}
class MockProduct extends Mock implements ProductEntity {}
class MockWorkoutLog extends Mock implements WorkoutLogEntity {}

// ============================================================
// TEST CONSTANTS
// ============================================================

class TestConstants {
  TestConstants._();

  // Test Member Data
  static const validMember = {
    'id': 'MEM001',
    'full_name': 'علی محمدی',
    'phone': '09123456789',
    'email': 'ali@example.com',
    'gender': 'MALE',
    'birth_date': '1990-01-15',
    'membership_status': 'ACTIVE',
    'membership_type': 'MONTHLY',
    'membership_expiry_date': '2024-12-31',
    'outstanding_balance': 0,
    'total_paid': 500000,
    'total_visits': 25,
    'is_active': 1,
    'is_blocked': 0,
    'created_at': '2024-01-01T00:00:00',
  };

  static const invalidMember = {
    'id': '',
    'full_name': '',
    'phone': '123',
    'email': 'invalid-email',
    'gender': 'INVALID',
    'birth_date': '2015-01-01', // Too young
  };

  static const expiredMember = {
    'id': 'MEM002',
    'full_name': 'رضا احمدی',
    'phone': '09123456790',
    'membership_status': 'EXPIRED',
    'membership_expiry_date': '2024-01-01',
    'is_active': 1,
    'is_blocked': 0,
  };

  static const blockedMember = {
    'id': 'MEM003',
    'full_name': 'سارا کریمی',
    'phone': '09123456791',
    'membership_status': 'ACTIVE',
    'membership_expiry_date': '2024-12-31',
    'is_active': 1,
    'is_blocked': 1,
  };

  // Test Payment Data
  static const validPayment = {
    'id': 'PAY001',
    'member_id': 'MEM001',
    'amount': 500000,
    'payment_date': '2024-01-15',
    'payment_type': 'MEMBERSHIP',
    'payment_method': 'CASH',
    'payment_status': 'PAID',
  };

  static const partialPayment = {
    'id': 'PAY002',
    'member_id': 'MEM001',
    'amount': 250000,
    'payment_date': '2024-01-15',
    'payment_type': 'MEMBERSHIP',
    'payment_method': 'CARD',
    'payment_status': 'PARTIAL',
    'remaining_amount': 250000,
  };

  // Test Product Data
  static const validProduct = {
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
  };

  static const lowStockProduct = {
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
  };

  // Test Order Data
  static const validOrder = {
    'id': 'ORD001',
    'order_number': 'ORD-20240115-001',
    'member_id': 'MEM001',
    'subtotal': 150000,
    'discount_amount': 0,
    'tax_amount': 15000,
    'total_price': 165000,
    'order_status': 'PENDING',
    'payment_status': 'UNPAID',
    'created_at': '2024-01-15T10:30:00',
  };

  // Test Dates
  static final today = DateTime.now();
  static final yesterday = DateTime.now().subtract(const Duration(days: 1));
  static final tomorrow = DateTime.now().add(const Duration(days: 1));
  static final nextWeek = DateTime.now().add(const Duration(days: 7));
  static final lastMonth = DateTime.now().subtract(const Duration(days: 30));

  // Test Amounts
  static const validAmount = 500000.0;
  static const zeroAmount = 0.0;
  static const negativeAmount = -100000.0;
  static const excessiveAmount = 999999999999.0;
}

// ============================================================
// TEST HELPERS
// ============================================================

class TestHelpers {
  TestHelpers._();

  // Generate test member with custom fields
  static Map<String, dynamic> generateMember({
    String? id,
    String? phone,
    String? membershipStatus,
    DateTime? expiryDate,
  }) {
    return {
      'id': id ?? 'MEM${DateTime.now().millisecondsSinceEpoch}',
      'full_name': 'عضو تست',
      'phone': phone ?? '09123456789',
      'email': 'test@example.com',
      'gender': 'MALE',
      'birth_date': '1990-01-01',
      'membership_status': membershipStatus ?? 'ACTIVE',
      'membership_type': 'MONTHLY',
      'membership_expiry_date': (expiryDate ?? DateTime.now().add(const Duration(days: 30))).toIso8601String(),
      'outstanding_balance': 0,
      'total_paid': 500000,
      'total_visits': 0,
      'is_active': 1,
      'is_blocked': 0,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  // Generate test payment
  static Map<String, dynamic> generatePayment({
    String? id,
    String? memberId,
    double? amount,
    String? status,
  }) {
    return {
      'id': id ?? 'PAY${DateTime.now().millisecondsSinceEpoch}',
      'member_id': memberId ?? 'MEM001',
      'amount': amount ?? 500000,
      'payment_date': DateTime.now().toIso8601String(),
      'payment_type': 'MEMBERSHIP',
      'payment_method': 'CASH',
      'payment_status': status ?? 'PAID',
    };
  }

  // Generate test product
  static Map<String, dynamic> generateProduct({
    String? id,
    String? name,
    double? price,
    double? stock,
  }) {
    return {
      'id': id ?? 'PROD${DateTime.now().millisecondsSinceEpoch}',
      'product_name': name ?? 'محصول تست',
      'barcode': '123456${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 6)}',
      'category_id': 'CAT001',
      'selling_price': price ?? 100000,
      'cost_price': (price ?? 100000) * 0.7,
      'current_stock': stock ?? 50,
      'min_stock_level': 10,
      'max_stock_level': 100,
      'unit': 'PIECE',
      'is_active': 1,
    };
  }

  // Generate test order
  static Map<String, dynamic> generateOrder({
    String? id,
    String? status,
    double? total,
  }) {
    return {
      'id': id ?? 'ORD${DateTime.now().millisecondsSinceEpoch}',
      'order_number': 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      'member_id': 'MEM001',
      'subtotal': total ?? 100000,
      'discount_amount': 0,
      'tax_amount': (total ?? 100000) * 0.1,
      'total_price': (total ?? 100000) * 1.1,
      'order_status': status ?? 'PENDING',
      'payment_status': 'UNPAID',
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  // Generate list of test members
  static List<Map<String, dynamic>> generateMemberList(int count) {
    return List.generate(count, (index) => generateMember(
      id: 'MEM${index + 1}',
      phone: '0912345${(10000 + index).toString().padLeft(5, '0')}',
    ));
  }

  // Generate list of test products
  static List<Map<String, dynamic>> generateProductList(int count) {
    return List.generate(count, (index) => generateProduct(
      id: 'PROD${index + 1}',
      name: 'محصول ${index + 1}',
      stock: (index % 3 == 0) ? 5 : 50, // Some low stock
    ));
  }

  // Create mock database
  static Future<void> setupMockDatabase() async {
    // Setup in-memory database for testing
  }

  // Clean up test database
  static Future<void> cleanupTestDatabase() async {
    // Clean up after tests
  }
}

// ============================================================
// CUSTOM MATCHERS
// ============================================================

class CustomMatchers {
  CustomMatchers._();

  // Matcher for valid phone number
  static Matcher isValidPhone() {
    return _IsValidPhoneMatcher();
  }

  // Matcher for valid email
  static Matcher isValidEmail() {
    return _IsValidEmailMatcher();
  }

  // Matcher for valid amount
  static Matcher isValidAmount() {
    return _IsValidAmountMatcher();
  }

  // Matcher for Persian text
  static Matcher containsPersianText() {
    return _ContainsPersianTextMatcher();
  }
}

class _IsValidPhoneMatcher extends Matcher {
  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! String) return false;
    if (item.length != 11) return false;
    if (!item.startsWith('09')) return false;
    return RegExp(r'^[0-9]+$').hasMatch(item);
  }

  @override
  Description describe(Description description) {
    return description.add('is a valid Iranian phone number');
  }
}

class _IsValidEmailMatcher extends Matcher {
  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! String) return false;
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(item);
  }

  @override
  Description describe(Description description) {
    return description.add('is a valid email address');
  }
}

class _IsValidAmountMatcher extends Matcher {
  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! double) return false;
    return item > 0;
  }

  @override
  Description describe(Description description) {
    return description.add('is a valid positive amount');
  }
}

class _ContainsPersianTextMatcher extends Matcher {
  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! String) return false;
    return RegExp(r'[\u0600-\u06FF]').hasMatch(item);
  }

  @override
  Description describe(Description description) {
    return description.add('contains Persian text');
  }
}