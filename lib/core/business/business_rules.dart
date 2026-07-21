// ============================================================
// CORE BUSINESS LOGIC & WORKFLOWS
// ============================================================
// This file defines all business rules, workflows, and core
// features for the Gym & Buffet Management system.
// ============================================================

class BusinessRules {
  BusinessRules._();

  // ============================================================
  // MEMBER MANAGEMENT RULES
  // ============================================================

  static const int minimumAge = 16;
  static const int maximumAge = 100;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int maxPhoneLength = 11;
  static const String phonePrefix = '09';
  static const int maxGracePeriodDays = 3;
  static const double renewalDiscountPercentage = 10;
  static const int renewalDiscountDays = 7;

  // ============================================================
  // MEMBERSHIP RULES
  // ============================================================

  static const int monthlyDays = 30;
  static const int quarterlyDays = 90;
  static const int annualDays = 365;
  static const int lifetimeDays = 36500; // 100 years

  // Membership status validation
  static bool canAccessGym({
    required String membershipStatus,
    required DateTime expiryDate,
    required bool isBlocked,
    required double outstandingBalance,
  }) {
    if (isBlocked) return false;
    if (membershipStatus != 'ACTIVE') return false;
    if (expiryDate.isBefore(DateTime.now())) return false;
    return true;
  }

  // ============================================================
  // PAYMENT RULES
  // ============================================================

  static const int paymentReminderDaysBefore = 3;
  static const int overdueGracePeriodDays = 1;
  static const double maximumDiscountPercentage = 50;
  static const double staffDiscountPercentage = 20;
  static const double memberDiscountPercentage = 10;
  static const int bulkDiscountQuantity = 5;
  static const double defaultTaxRate = 0.10; // 10%

  // Payment validation
  static bool isValidPayment(double amount) {
    return amount > 0;
  }

  static double calculateDiscount(double originalAmount, double discountPercentage) {
    if (discountPercentage > maximumDiscountPercentage) {
      discountPercentage = maximumDiscountPercentage;
    }
    return originalAmount * (discountPercentage / 100);
  }

  static double calculateTax(double amount, double taxRate) {
    return amount * taxRate;
  }

  // ============================================================
  // ATTENDANCE RULES
  // ============================================================

  static const int minimumSessionMinutes = 5;
  static const int maximumSessionMinutes = 240; // 4 hours
  static const int autoCheckoutHour = 23; // 11 PM
  static const int autoCheckoutMinutes = 240; // 4 hours after check-in
  static const int maxGymCapacity = 100;
  static const int inactivityReminderDays = 7;

  // ============================================================
  // BUFFET RULES
  // ============================================================

  static const int maximumItemsPerOrder = 50;
  static const int lowStockThreshold = 10;
  static const double maximumDiscountPercentageBuffet = 50;

  // ============================================================
  // ACCOUNTING RULES
  // ============================================================

  static const int invoiceDueDays = 30;
  static const int overdueInterestPercentage = 2;
  static const List<int> installmentOptions = [3, 6, 12];

  // ============================================================
  // REPORTING RULES
  // ============================================================

  static const int reportRetentionDays = 365;
  static const int maxExportRows = 10000;
}

// ============================================================
// WORKFLOW DEFINITIONS
// ============================================================

class Workflows {
  Workflows._();

  // ============================================================
  // MEMBER CHECK-IN WORKFLOW
  // ============================================================
  static const Map<String, dynamic> checkInWorkflow = {
    'name': 'Member Check-in',
    'steps': [
      'Scan QR code or enter member ID',
      'Validate member exists in database',
      'Check membership status is ACTIVE',
      'Check membership expiry date is not past',
      'Check member is not blocked',
      'Check member is not already checked in',
      'Check gym capacity is not full',
      'Create attendance record with check-in time',
      'Update member last visit date',
      'Update member total visits count',
      'Display success message with member name',
    ],
    'error_handling': [
      'Member not found: Display error message',
      'Membership expired: Prompt for renewal',
      'Member blocked: Display restriction message',
      'Already checked in: Display current session info',
      'Gym full: Display capacity message',
    ],
  };

  // ============================================================
  // MEMBER CHECK-OUT WORKFLOW
  // ============================================================
  static const Map<String, dynamic> checkOutWorkflow = {
    'name': 'Member Check-out',
    'steps': [
      'Find active attendance record for member',
      'Calculate session duration',
      'Update attendance record with check-out time',
      'Update duration in minutes',
      'Display session summary',
    ],
    'auto_checkout': {
      'trigger': 'Gym closing time (11 PM) or 4 hours after check-in',
      'action': 'Auto checkout all active members',
      'notification': 'Send notification to members who forgot to checkout',
    },
  };

  // ============================================================
  // MEMBER REGISTRATION WORKFLOW
  // ============================================================
  static const Map<String, dynamic> registrationWorkflow = {
    'name': 'New Member Registration',
    'steps': [
      'Collect personal information',
      'Validate phone number format and uniqueness',
      'Validate name length and format',
      'Validate age (minimum 16 years)',
      'Collect physical measurements',
      'Collect emergency contact information',
      'Select membership plan',
      'Calculate membership expiry date',
      'Record initial payment',
      'Create member record in database',
      'Generate member ID',
      'Display confirmation with member details',
    ],
    'required_fields': ['firstName', 'lastName', 'phone', 'gender', 'birthDate', 'membershipType'],
    'optional_fields': ['email', 'nationalId', 'address', 'allergies', 'medicalConditions'],
  };

  // ============================================================
  // MEMBERSHIP RENEWAL WORKFLOW
  // ============================================================
  static const Map<String, dynamic> renewalWorkflow = {
    'name': 'Membership Renewal',
    'steps': [
      'Display current membership status',
      'Show days until expiry',
      'Calculate renewal discount (if applicable)',
      'Select new membership plan',
      'Calculate new expiry date',
      'Process payment',
      'Update membership record',
      'Update membership status to ACTIVE',
      'Send renewal confirmation',
    ],
    'discount_rules': {
      'early_renewal': {
        'days_before': 7,
        'discount_percentage': 10,
      },
      'grace_period': {
        'days_after_expiry': 3,
        'allowed': true,
      },
    },
  };

  // ============================================================
  // PAYMENT PROCESSING WORKFLOW
  // ============================================================
  static const Map<String, dynamic> paymentWorkflow = {
    'name': 'Payment Processing',
    'steps': [
      'Select member or guest',
      'Enter payment amount',
      'Select payment method',
      'Select payment type (membership/service/product)',
      'Validate payment amount',
      'Record payment transaction',
      'Update member balance',
      'Generate receipt',
      'Display confirmation',
    ],
    'payment_methods': ['CASH', 'CARD', 'TRANSFER', 'INSTALLMENT', 'FREE'],
    'payment_types': ['MEMBERSHIP', 'SERVICE', 'PRODUCT', 'PENALTY', 'OTHER'],
  };

  // ============================================================
  // ORDER CREATION WORKFLOW
  // ============================================================
  static const Map<String, dynamic> orderWorkflow = {
    'name': 'Order Creation',
    'steps': [
      'Select or create customer (member/guest)',
      'Add items to cart',
      'Validate stock availability',
      'Calculate subtotal',
      'Apply discount (if any)',
      'Calculate tax',
      'Calculate grand total',
      'Select payment method',
      'Create order record',
      'Update inventory stock',
      'Generate order number',
      'Display order confirmation',
    ],
    'status_flow': ['PENDING', 'PREPARING', 'READY', 'COMPLETED', 'CANCELLED'],
    'cancellation_rules': {
      'allowed_statuses': ['PENDING', 'PREPARING'],
      'restock_on_cancel': true,
    },
  };

  // ============================================================
  // EXPENSE RECORDING WORKFLOW
  // ============================================================
  static const Map<String, dynamic> expenseWorkflow = {
    'name': 'Expense Recording',
    'steps': [
      'Select expense category',
      'Enter amount',
      'Enter description',
      'Select date',
      'Attach receipt (optional)',
      'Record transaction',
      'Update expense totals',
      'Display confirmation',
    ],
    'categories': ['SALARY', 'RENT', 'UTILITIES', 'SUPPLIES', 'MAINTENANCE', 'MARKETING', 'OTHER'],
  };

  // ============================================================
  // INVOICE GENERATION WORKFLOW
  // ============================================================
  static const Map<String, dynamic> invoiceWorkflow = {
    'name': 'Invoice Generation',
    'steps': [
      'Select member',
      'Add invoice items',
      'Calculate subtotal',
      'Apply discount',
      'Calculate tax',
      'Calculate total',
      'Set due date',
      'Generate invoice number',
      'Save invoice record',
      'Display invoice preview',
    ],
    'invoice_number_format': 'INV-YYYYMMDD-XXX',
    'default_due_days': 30,
  };

  // ============================================================
  // DAILY REPORT WORKFLOW
  // ============================================================
  static const Map<String, dynamic> dailyReportWorkflow = {
    'name': 'Daily Report Generation',
    'trigger': '11:59 PM daily (automatic)',
    'steps': [
      'Collect attendance data for the day',
      'Collect order data for the day',
      'Collect payment data for the day',
      'Collect transaction data for the day',
      'Calculate daily totals',
      'Generate summary statistics',
      'Save report to database',
      'Send notification to admin',
    ],
    'metrics': [
      'Total attendance',
      'Total orders',
      'Total sales',
      'Total income',
      'Total expenses',
      'Net profit',
    ],
  };

  // ============================================================
  // BACKUP WORKFLOW
  // ============================================================
  static const Map<String, dynamic> backupWorkflow = {
    'name': 'Database Backup',
    'manual_trigger': 'User initiates backup',
    'auto_trigger': 'Configurable schedule (daily/weekly)',
    'steps': [
      'Validate database integrity',
      'Create backup file',
      'Compress backup file',
      'Save to local storage',
      'Display backup confirmation',
      'Show backup details (size, date)',
    ],
    'restore_steps': [
      'Select backup file',
      'Validate backup file',
      'Show restore confirmation',
      'Close all database connections',
      'Restore database from backup',
      'Reopen database connections',
      'Verify data integrity',
      'Display restore confirmation',
    ],
  };
}

// ============================================================
// BUSINESS VALIDATORS
// ============================================================

class BusinessValidators {
  BusinessValidators._();

  // ============================================================
  // MEMBER VALIDATORS
  // ============================================================

  static String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'شماره تلفن الزامی است';
    }
    if (phone.length != 11) {
      return 'شماره تلفن باید 11 رقم باشد';
    }
    if (!phone.startsWith('09')) {
      return 'شماره تلفن باید با 09 شروع شود';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      return 'شماره تلفن فقط شامل اعداد باشد';
    }
    return null;
  }

  static String? validateName(String? name, String fieldName) {
    if (name == null || name.trim().isEmpty) {
      return '$fieldName الزامی است';
    }
    if (name.trim().length < BusinessRules.minNameLength) {
      return '$fieldName باید حداقل ${BusinessRules.minNameLength} کاراکتر باشد';
    }
    if (name.trim().length > BusinessRules.maxNameLength) {
      return '$fieldName باید حداکثر ${BusinessRules.maxNameLength} کاراکتر باشد';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return null; // Optional field
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'فرمت ایمیل نامعتبر است';
    }
    return null;
  }

  static String? validateBirthDate(DateTime? birthDate) {
    if (birthDate == null) {
      return 'تاریخ تولد الزامی است';
    }
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    if (age < BusinessRules.minimumAge) {
      return 'حداقل سن عضویت ${BusinessRules.minimumAge} سال است';
    }
    if (age > BusinessRules.maximumAge) {
      return 'سن وارد شده نامعتبر است';
    }
    return null;
  }

  static String? validateHeight(double? height) {
    if (height == null || height <= 0) {
      return 'قد وارد شده نامعتبر است';
    }
    if (height < 100 || height > 250) {
      return 'قد باید بین 100 تا 250 سانتی‌متر باشد';
    }
    return null;
  }

  static String? validateWeight(double? weight) {
    if (weight == null || weight <= 0) {
      return 'وزن وارد شده نامعتبر است';
    }
    if (weight < 30 || weight > 300) {
      return 'وزن باید بین 30 تا 300 کیلوگرم باشد';
    }
    return null;
  }

  // ============================================================
  // PAYMENT VALIDATORS
  // ============================================================

  static String? validatePaymentAmount(double? amount) {
    if (amount == null || amount <= 0) {
      return 'مبلغ پرداخت باید بیشتر از صفر باشد';
    }
    return null;
  }

  static String? validateDiscount(double? discount, double originalAmount) {
    if (discount == null || discount < 0) {
      return 'تخفیف نامعتبر است';
    }
    if (discount > originalAmount) {
      return 'تخفیف نمی‌تواند بیشتر از مبلغ اصلی باشد';
    }
    final discountPercentage = (discount / originalAmount) * 100;
    if (discountPercentage > BusinessRules.maximumDiscountPercentage) {
      return 'حداکثر تخفیف ${BusinessRules.maximumDiscountPercentage}% است';
    }
    return null;
  }

  // ============================================================
  // PRODUCT VALIDATORS
  // ============================================================

  static String? validateProductName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'نام محصول الزامی است';
    }
    if (name.trim().length < 2) {
      return 'نام محصول باید حداقل 2 کاراکتر باشد';
    }
    return null;
  }

  static String? validateBarcode(String? barcode) {
    if (barcode == null || barcode.isEmpty) {
      return null; // Optional
    }
    if (barcode.length != 12 && barcode.length != 13) {
      return 'بارکد باید 12 یا 13 رقم باشد';
    }
    return null;
  }

  static String? validatePrice(double? price) {
    if (price == null || price <= 0) {
      return 'قیمت باید بیشتر از صفر باشد';
    }
    return null;
  }

  static String? validateStock(double? stock) {
    if (stock == null || stock < 0) {
      return 'موجودی نمی‌تواند منفی باشد';
    }
    return null;
  }

  // ============================================================
  // ORDER VALIDATORS
  // ============================================================

  static String? validateOrderItems(List<dynamic>? items) {
    if (items == null || items.isEmpty) {
      return 'سفارش باید حداقل یک آیتم داشته باشد';
    }
    if (items.length > BusinessRules.maximumItemsPerOrder) {
      return 'حداکثر ${BusinessRules.maximumItemsPerOrder} آیتم در هر سفارش';
    }
    return null;
  }

  static String? validateQuantity(int? quantity) {
    if (quantity == null || quantity <= 0) {
      return 'تعداد باید بیشتر از صفر باشد';
    }
    return null;
  }

  // ============================================================
  // EXPENSE VALIDATORS
  // ============================================================

  static String? validateExpenseCategory(String? category) {
    if (category == null || category.isEmpty) {
      return 'دسته‌بندی هزینه الزامی است';
    }
    return null;
  }

  static String? validateExpenseAmount(double? amount) {
    if (amount == null || amount <= 0) {
      return 'مبلغ هزینه باید بیشتر از صفر باشد';
    }
    return null;
  }

  static String? validateDescription(String? description, {bool required = false}) {
    if (required && (description == null || description.trim().isEmpty)) {
      return 'توضیحات الزامی است';
    }
    return null;
  }
}

// ============================================================
// CALCULATION UTILITIES
// ============================================================

class CalculationUtils {
  CalculationUtils._();

  // ============================================================
  // MEMBERSHIP CALCULATIONS
  // ============================================================

  static DateTime calculateExpiryDate(DateTime startDate, String membershipType) {
    switch (membershipType) {
      case 'MONTHLY':
        return startDate.add(const Duration(days: BusinessRules.monthlyDays));
      case 'QUARTERLY':
        return startDate.add(const Duration(days: BusinessRules.quarterlyDays));
      case 'ANNUAL':
        return startDate.add(const Duration(days: BusinessRules.annualDays));
      case 'LIFETIME':
        return startDate.add(const Duration(days: BusinessRules.lifetimeDays));
      default:
        return startDate.add(const Duration(days: BusinessRules.monthlyDays));
    }
  }

  static int calculateDaysRemaining(DateTime expiryDate) {
    final now = DateTime.now();
    if (expiryDate.isBefore(now)) return 0;
    return expiryDate.difference(now).inDays;
  }

  static bool isExpiringSoon(DateTime expiryDate, int daysThreshold) {
    final daysRemaining = calculateDaysRemaining(expiryDate);
    return daysRemaining <= daysThreshold && daysRemaining > 0;
  }

  static bool isExpired(DateTime expiryDate) {
    return expiryDate.isBefore(DateTime.now());
  }

  // ============================================================
  // PAYMENT CALCULATIONS
  // ============================================================

  static double calculateDiscount(double amount, double discountPercentage) {
    if (discountPercentage > BusinessRules.maximumDiscountPercentage) {
      discountPercentage = BusinessRules.maximumDiscountPercentage;
    }
    return amount * (discountPercentage / 100);
  }

  static double calculateTax(double amount, double taxRate) {
    return amount * taxRate;
  }

  static double calculateTotalWithTax(double amount, double taxRate) {
    return amount + calculateTax(amount, taxRate);
  }

  static double calculateGrandTotal({
    required double subtotal,
    double discount = 0,
    double taxRate = BusinessRules.defaultTaxRate,
  }) {
    final afterDiscount = subtotal - discount;
    final tax = calculateTax(afterDiscount, taxRate);
    return afterDiscount + tax;
  }

  static double calculateInstallmentAmount(double totalAmount, int installmentCount) {
    return totalAmount / installmentCount;
  }

  static List<Map<String, dynamic>> generateInstallmentPlan({
    required double totalAmount,
    required int installmentCount,
    required DateTime startDate,
  }) {
    final installmentAmount = calculateInstallmentAmount(totalAmount, installmentCount);
    final plan = <Map<String, dynamic>>[];

    for (int i = 0; i < installmentCount; i++) {
      plan.add({
        'number': i + 1,
        'amount': installmentAmount,
        'dueDate': DateTime(
          startDate.year,
          startDate.month + i + 1,
          startDate.day,
        ),
        'isPaid': false,
        'paidDate': null,
      });
    }

    return plan;
  }

  // ============================================================
  // HEALTH CALCULATIONS
  // ============================================================

  static double calculateBMI(double weightKg, double heightCm) {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  static String getBMICategory(double bmi) {
    if (bmi < 18.5) return 'کمبود وزن';
    if (bmi < 25) return 'نرمال';
    if (bmi < 30) return 'اضافه وزن';
    return 'چاق';
  }

  static double calculateBMR({
    required double weightKg,
    required double heightCm,
    required int age,
    required String gender,
  }) {
    // Mifflin-St Jeor Equation
    if (gender == 'MALE') {
      return 10 * weightKg + 6.25 * heightCm - 5 * age + 5;
    } else {
      return 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
    }
  }

  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // ============================================================
  // WORKOUT CALCULATIONS
  // ============================================================

  static double calculateOneRepMax(double weight, int reps) {
    if (reps == 1) return weight;
    // Epley formula
    return weight * (1 + reps / 30);
  }

  static double calculateVolume(int sets, int reps, double weight) {
    return sets * reps * weight;
  }

  static double calculateWorkoutDuration({
    required int exerciseCount,
    required int setsPerExercise,
    required int repsPerSet,
    required int restSeconds,
  }) {
    final exerciseTime = exerciseCount * setsPerExercise * repsPerSet * 3; // 3 seconds per rep
    final restTime = exerciseCount * (setsPerExercise - 1) * restSeconds;
    return (exerciseTime + restTime) / 60; // Convert to minutes
  }

  static Map<String, double> calculateProgressMetrics({
    required double previousWeight,
    required double currentWeight,
    required double previousBodyFat,
    required double currentBodyFat,
    required double previousMuscleMass,
    required double currentMuscleMass,
  }) {
    return {
      'weightChange': currentWeight - previousWeight,
      'bodyFatChange': currentBodyFat - previousBodyFat,
      'muscleMassChange': currentMuscleMass - previousMuscleMass,
      'weightChangePercentage': previousWeight > 0
          ? ((currentWeight - previousWeight) / previousWeight) * 100
          : 0,
      'bodyFatChangePercentage': previousBodyFat > 0
          ? ((currentBodyFat - previousBodyFat) / previousBodyFat) * 100
          : 0,
      'muscleMassChangePercentage': previousMuscleMass > 0
          ? ((currentMuscleMass - previousMuscleMass) / previousMuscleMass) * 100
          : 0,
    };
  }

  // ============================================================
  // ATTENDANCE CALCULATIONS
  // ============================================================

  static int calculateDurationMinutes(DateTime checkIn, DateTime checkOut) {
    return checkOut.difference(checkIn).inMinutes;
  }

  static String formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours == 0) return '$mins دقیقه';
    if (mins == 0) return '$hours ساعت';
    return '$hours ساعت و $mins دقیقه';
  }

  static Map<int, int> calculatePeakHours(List<DateTime> checkInTimes) {
    final peakHours = <int, int>{};
    for (final time in checkInTimes) {
      final hour = time.hour;
      peakHours[hour] = (peakHours[hour] ?? 0) + 1;
    }
    return peakHours;
  }

  // ============================================================
  // FINANCIAL CALCULATIONS
  // ============================================================

  static double calculateProfit(double income, double expense) {
    return income - expense;
  }

  static double calculateProfitMargin(double income, double profit) {
    if (income == 0) return 0;
    return (profit / income) * 100;
  }

  static Map<String, double> calculateFinancialSummary({
    required List<Map<String, dynamic>> incomeTransactions,
    required List<Map<String, dynamic>> expenseTransactions,
  }) {
    final totalIncome = incomeTransactions.fold<double>(
      0,
      (sum, t) => sum + (t['amount'] as double),
    );
    final totalExpense = expenseTransactions.fold<double>(
      0,
      (sum, t) => sum + (t['amount'] as double),
    );
    final netProfit = calculateProfit(totalIncome, totalExpense);
    final profitMargin = calculateProfitMargin(totalIncome, netProfit);

    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'netProfit': netProfit,
      'profitMargin': profitMargin,
    };
  }

  // ============================================================
  // STOCK CALCULATIONS
  // ============================================================

  static String getStockStatus(double currentStock, double minStock, double maxStock) {
    if (currentStock <= 0) return 'OUT_OF_STOCK';
    if (currentStock <= minStock) return 'LOW_STOCK';
    return 'IN_STOCK';
  }

  static bool needsRestocking(double currentStock, double minStock) {
    return currentStock <= minStock;
  }

  static double getStockPercentage(double currentStock, double maxStock) {
    if (maxStock == 0) return 0;
    return (currentStock / maxStock) * 100;
  }

  static double calculateStockValue(double quantity, double unitCost) {
    return quantity * unitCost;
  }
}

// ============================================================
// ID GENERATORS
// ============================================================

class IdGenerators {
  IdGenerators._();

  static String generateMemberId() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return 'MEM$datePart$randomPart';
  }

  static String generatePaymentId() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return 'PAY$datePart$randomPart';
  }

  static String generateOrderId() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return 'ORD$datePart$randomPart';
  }

  static String generateOrderNumber() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return 'ORD-$datePart-$randomPart';
  }

  static String generateTransactionId() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return 'TRX$datePart$randomPart';
  }

  static String generateTransactionNumber() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return 'TRX-$datePart-$randomPart';
  }

  static String generateInvoiceId() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return 'INV$datePart$randomPart';
  }

  static String generateInvoiceNumber() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return 'INV-$datePart-$randomPart';
  }

  static String generateAttendanceId() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final timePart = '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
    return 'ATT$datePart$timePart';
  }
}