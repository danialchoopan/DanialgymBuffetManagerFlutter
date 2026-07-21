import 'package:flutter_test/flutter_test.dart';
import 'package:gym_buffet_manager/core/business/business_rules.dart';

void main() {
  group('BusinessValidators', () {
    group('validatePhoneNumber', () {
      test('should return null for valid phone number', () {
        expect(BusinessValidators.validatePhoneNumber('09123456789'), isNull);
      });

      test('should return error for empty phone', () {
        expect(
          BusinessValidators.validatePhoneNumber(''),
          equals('شماره تلفن الزامی است'),
        );
      });

      test('should return error for null phone', () {
        expect(
          BusinessValidators.validatePhoneNumber(null),
          equals('شماره تلفن الزامی است'),
        );
      });

      test('should return error for short phone', () {
        expect(
          BusinessValidators.validatePhoneNumber('0912345'),
          equals('شماره تلفن باید 11 رقم باشد'),
        );
      });

      test('should return error for phone not starting with 09', () {
        expect(
          BusinessValidators.validatePhoneNumber('08123456789'),
          equals('شماره تلفن باید با 09 شروع شود'),
        );
      });

      test('should return error for non-numeric phone', () {
        expect(
          BusinessValidators.validatePhoneNumber('0912345abcde'),
          equals('شماره تلفن فقط شامل اعداد باشد'),
        );
      });
    });

    group('validateName', () {
      test('should return null for valid name', () {
        expect(
          BusinessValidators.validateName('علی', 'نام'),
          isNull,
        );
      });

      test('should return error for empty name', () {
        expect(
          BusinessValidators.validateName('', 'نام'),
          equals('نام الزامی است'),
        );
      });

      test('should return error for null name', () {
        expect(
          BusinessValidators.validateName(null, 'نام'),
          equals('نام الزامی است'),
        );
      });

      test('should return error for short name', () {
        expect(
          BusinessValidators.validateName('ا', 'نام'),
          equals('نام باید حداقل 2 کاراکتر باشد'),
        );
      });

      test('should return error for long name', () {
        final longName = 'نام خیلی طولانی که بیشتر از پنجاه کاراکتر است و باید خطا دهد';
        expect(
          BusinessValidators.validateName(longName, 'نام'),
          equals('نام باید حداکثر 50 کاراکتر باشد'),
        );
      });
    });

    group('validateEmail', () {
      test('should return null for valid email', () {
        expect(
          BusinessValidators.validateEmail('test@example.com'),
          isNull,
        );
      });

      test('should return null for empty email (optional)', () {
        expect(
          BusinessValidators.validateEmail(''),
          isNull,
        );
      });

      test('should return null for null email (optional)', () {
        expect(
          BusinessValidators.validateEmail(null),
          isNull,
        );
      });

      test('should return error for invalid email format', () {
        expect(
          BusinessValidators.validateEmail('invalid-email'),
          equals('فرمت ایمیل نامعتبر است'),
        );
      });

      test('should return error for email without domain', () {
        expect(
          BusinessValidators.validateEmail('test@'),
          equals('فرمت ایمیل نامعتبر است'),
        );
      });
    });

    group('validateBirthDate', () {
      test('should return null for valid birth date', () {
        final validDate = DateTime.now().subtract(const Duration(days: 365 * 25));
        expect(
          BusinessValidators.validateBirthDate(validDate),
          isNull,
        );
      });

      test('should return error for null birth date', () {
        expect(
          BusinessValidators.validateBirthDate(null),
          equals('تاریخ تولد الزامی است'),
        );
      });

      test('should return error for underage person', () {
        final underageDate = DateTime.now().subtract(const Duration(days: 365 * 15));
        expect(
          BusinessValidators.validateBirthDate(underageDate),
          equals('حداقل سن عضویت 16 سال است'),
        );
      });
    });

    group('validateHeight', () {
      test('should return null for valid height', () {
        expect(BusinessValidators.validateHeight(175), isNull);
      });

      test('should return error for null height', () {
        expect(
          BusinessValidators.validateHeight(null),
          equals('قد وارد شده نامعتبر است'),
        );
      });

      test('should return error for zero height', () {
        expect(
          BusinessValidators.validateHeight(0),
          equals('قد وارد شده نامعتبر است'),
        );
      });

      test('should return error for too short height', () {
        expect(
          BusinessValidators.validateHeight(50),
          equals('قد باید بین 100 تا 250 سانتی‌متر باشد'),
        );
      });

      test('should return error for too tall height', () {
        expect(
          BusinessValidators.validateHeight(300),
          equals('قد باید بین 100 تا 250 سانتی‌متر باشد'),
        );
      });
    });

    group('validateWeight', () {
      test('should return null for valid weight', () {
        expect(BusinessValidators.validateWeight(75), isNull);
      });

      test('should return error for null weight', () {
        expect(
          BusinessValidators.validateWeight(null),
          equals('وزن وارد شده نامعتبر است'),
        );
      });

      test('should return error for zero weight', () {
        expect(
          BusinessValidators.validateWeight(0),
          equals('وزن وارد شده نامعتبر است'),
        );
      });

      test('should return error for too light weight', () {
        expect(
          BusinessValidators.validateWeight(20),
          equals('وزن باید بین 30 تا 300 کیلوگرم باشد'),
        );
      });

      test('should return error for too heavy weight', () {
        expect(
          BusinessValidators.validateWeight(350),
          equals('وزن باید بین 30 تا 300 کیلوگرم باشد'),
        );
      });
    });
  });

  group('BusinessRules', () {
    test('canAccessGym should return true for valid active member', () {
      expect(
        BusinessRules.canAccessGym(
          membershipStatus: 'ACTIVE',
          expiryDate: DateTime.now().add(const Duration(days: 30)),
          isBlocked: false,
          outstandingBalance: 0,
        ),
        isTrue,
      );
    });

    test('canAccessGym should return false for blocked member', () {
      expect(
        BusinessRules.canAccessGym(
          membershipStatus: 'ACTIVE',
          expiryDate: DateTime.now().add(const Duration(days: 30)),
          isBlocked: true,
          outstandingBalance: 0,
        ),
        isFalse,
      );
    });

    test('canAccessGym should return false for expired membership', () {
      expect(
        BusinessRules.canAccessGym(
          membershipStatus: 'ACTIVE',
          expiryDate: DateTime.now().subtract(const Duration(days: 1)),
          isBlocked: false,
          outstandingBalance: 0,
        ),
        isFalse,
      );
    });

    test('canAccessGym should return false for inactive membership', () {
      expect(
        BusinessRules.canAccessGym(
          membershipStatus: 'EXPIRED',
          expiryDate: DateTime.now().add(const Duration(days: 30)),
          isBlocked: false,
          outstandingBalance: 0,
        ),
        isFalse,
      );
    });
  });

  group('CalculationUtils', () {
    group('calculateBMI', () {
      test('should calculate BMI correctly', () {
        // 75kg, 175cm
        final bmi = CalculationUtils.calculateBMI(75, 175);
        expect(bmi, closeTo(24.5, 0.1));
      });

      test('should return 0 for zero height', () {
        final bmi = CalculationUtils.calculateBMI(75, 0);
        expect(bmi, 0);
      });
    });

    group('getBMICategory', () {
      test('should return underweight for BMI < 18.5', () {
        expect(CalculationUtils.getBMICategory(17), equals('کمبود وزن'));
      });

      test('should return normal for BMI 18.5-25', () {
        expect(CalculationUtils.getBMICategory(22), equals('نرمال'));
      });

      test('should return overweight for BMI 25-30', () {
        expect(CalculationUtils.getBMICategory(27), equals('اضافه وزن'));
      });

      test('should return obese for BMI >= 30', () {
        expect(CalculationUtils.getBMICategory(35), equals('چاق'));
      });
    });

    group('calculateOneRepMax', () {
      test('should return weight for 1 rep', () {
        expect(CalculationUtils.calculateOneRepMax(100, 1), equals(100));
      });

      test('should calculate 1RM correctly using Epley formula', () {
        // 100kg × (1 + 5/30) = 116.67
        final oneRM = CalculationUtils.calculateOneRepMax(100, 5);
        expect(oneRM, closeTo(116.67, 0.1));
      });

      test('should calculate 1RM for high reps', () {
        // 80kg × (1 + 12/30) = 112
        final oneRM = CalculationUtils.calculateOneRepMax(80, 12);
        expect(oneRM, closeTo(112, 0.1));
      });
    });

    group('calculateVolume', () {
      test('should calculate volume correctly', () {
        // 3 sets × 10 reps × 100kg = 3000
        final volume = CalculationUtils.calculateVolume(3, 10, 100);
        expect(volume, equals(3000));
      });

      test('should return 0 for zero sets', () {
        final volume = CalculationUtils.calculateVolume(0, 10, 100);
        expect(volume, equals(0));
      });
    });

    group('calculateAge', () {
      test('should calculate age correctly', () {
        final birthDate = DateTime.now().subtract(const Duration(days: 365 * 25));
        final age = CalculationUtils.calculateAge(birthDate);
        expect(age, equals(25));
      });

      test('should calculate age correctly for birthday not yet passed', () {
        final birthDate = DateTime(
          DateTime.now().year - 25,
          DateTime.now().month + 1,
          DateTime.now().day,
        );
        final age = CalculationUtils.calculateAge(birthDate);
        expect(age, equals(24));
      });
    });

    group('calculateDiscount', () {
      test('should calculate discount correctly', () {
        final discount = CalculationUtils.calculateDiscount(100000, 10);
        expect(discount, equals(10000));
      });

      test('should cap discount at maximum', () {
        final discount = CalculationUtils.calculateDiscount(100000, 60);
        expect(discount, equals(50000)); // 50% max
      });
    });

    group('calculateTax', () {
      test('should calculate tax correctly', () {
        final tax = CalculationUtils.calculateTax(100000, 0.1);
        expect(tax, equals(10000));
      });

      test('should return 0 for zero tax rate', () {
        final tax = CalculationUtils.calculateTax(100000, 0);
        expect(tax, equals(0));
      });
    });

    group('calculateGrandTotal', () {
      test('should calculate grand total correctly', () {
        final total = CalculationUtils.calculateGrandTotal(
          subtotal: 100000,
          discount: 10000,
          taxRate: 0.1,
        );
        // (100000 - 10000) × 1.1 = 99000
        expect(total, equals(99000));
      });
    });

    group('getStockStatus', () {
      test('should return OUT_OF_STOCK for zero stock', () {
        expect(
          CalculationUtils.getStockStatus(0, 10, 100),
          equals('OUT_OF_STOCK'),
        );
      });

      test('should return LOW_STOCK for stock below minimum', () {
        expect(
          CalculationUtils.getStockStatus(5, 10, 100),
          equals('LOW_STOCK'),
        );
      });

      test('should return IN_STOCK for normal stock', () {
        expect(
          CalculationUtils.getStockStatus(50, 10, 100),
          equals('IN_STOCK'),
        );
      });
    });

    group('calculateExpiryDate', () {
      test('should calculate monthly expiry correctly', () {
        final startDate = DateTime(2024, 1, 1);
        final expiry = CalculationUtils.calculateExpiryDate(startDate, 'MONTHLY');
        expect(expiry, equals(DateTime(2024, 1, 31)));
      });

      test('should calculate quarterly expiry correctly', () {
        final startDate = DateTime(2024, 1, 1);
        final expiry = CalculationUtils.calculateExpiryDate(startDate, 'QUARTERLY');
        expect(expiry, equals(DateTime(2024, 3, 31)));
      });

      test('should calculate annual expiry correctly', () {
        final startDate = DateTime(2024, 1, 1);
        final expiry = CalculationUtils.calculateExpiryDate(startDate, 'ANNUAL');
        expect(expiry, equals(DateTime(2024, 12, 31)));
      });
    });

    group('calculateDaysRemaining', () {
      test('should calculate days remaining correctly', () {
        final futureDate = DateTime.now().add(const Duration(days: 10));
        final days = CalculationUtils.calculateDaysRemaining(futureDate);
        expect(days, equals(10));
      });

      test('should return 0 for past date', () {
        final pastDate = DateTime.now().subtract(const Duration(days: 5));
        final days = CalculationUtils.calculateDaysRemaining(pastDate);
        expect(days, equals(0));
      });
    });

    group('isExpiringSoon', () {
      test('should return true for date expiring within threshold', () {
        final expiringDate = DateTime.now().add(const Duration(days: 3));
        expect(
          CalculationUtils.isExpiringSoon(expiringDate, 7),
          isTrue,
        );
      });

      test('should return false for date not expiring soon', () {
        final futureDate = DateTime.now().add(const Duration(days: 30));
        expect(
          CalculationUtils.isExpiringSoon(futureDate, 7),
          isFalse,
        );
      });
    });

    group('formatDuration', () {
      test('should format minutes correctly', () {
        expect(CalculationUtils.formatDuration(30), equals('30 دقیقه'));
      });

      test('should format hours correctly', () {
        expect(CalculationUtils.formatDuration(60), equals('1 ساعت'));
      });

      test('should format hours and minutes correctly', () {
        expect(CalculationUtils.formatDuration(90), equals('1 ساعت و 30 دقیقه'));
      });
    });
  });

  group('IdGenerators', () {
    test('should generate unique member IDs', () {
      final id1 = IdGenerators.generateMemberId();
      final id2 = IdGenerators.generateMemberId();
      expect(id1, isNot(equals(id2)));
      expect(id1, startsWith('MEM'));
    });

    test('should generate unique payment IDs', () {
      final id1 = IdGenerators.generatePaymentId();
      final id2 = IdGenerators.generatePaymentId();
      expect(id1, isNot(equals(id2)));
      expect(id1, startsWith('PAY'));
    });

    test('should generate unique order IDs', () {
      final id1 = IdGenerators.generateOrderId();
      final id2 = IdGenerators.generateOrderId();
      expect(id1, isNot(equals(id2)));
      expect(id1, startsWith('ORD'));
    });

    test('should generate order numbers with correct format', () {
      final orderNumber = IdGenerators.generateOrderNumber();
      expect(orderNumber, matches(RegExp(r'^ORD-\d{8}-\d+$')));
    });

    test('should generate transaction IDs', () {
      final id = IdGenerators.generateTransactionId();
      expect(id, startsWith('TRX'));
    });

    test('should generate invoice IDs', () {
      final id = IdGenerators.generateInvoiceId();
      expect(id, startsWith('INV'));
    });

    test('should generate invoice numbers with correct format', () {
      final invoiceNumber = IdGenerators.generateInvoiceNumber();
      expect(invoiceNumber, matches(RegExp(r'^INV-\d{8}-\d+$')));
    });

    test('should generate attendance IDs', () {
      final id = IdGenerators.generateAttendanceId();
      expect(id, startsWith('ATT'));
    });
  });
}