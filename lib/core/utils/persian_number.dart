// ============================================================
// PERSIAN NUMBER FORMATTING UTILITIES
// ============================================================
// Complete Persian number and currency formatting system
// ============================================================

class PersianNumber {
  PersianNumber._();

  // ============================================================
  // PERSIAN DIGITS MAP
  // ============================================================
  static const Map<String, String> persianDigits = {
    '0': '۰',
    '1': '۱',
    '2': '۲',
    '3': '۳',
    '4': '۴',
    '5': '۵',
    '6': '۶',
    '7': '۷',
    '8': '۸',
    '9': '۹',
  };

  static const Map<String, String> arabicDigits = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  // ============================================================
  // NUMBER TO PERSIAN CONVERSION
  // ============================================================

  static String toPersian(String input) {
    String result = input;
    for (final entry in persianDigits.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }

  static String toArabic(String input) {
    String result = input;
    for (final entry in arabicDigits.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }

  static String toEnglish(String persianInput) {
    String result = persianInput;
    for (final entry in persianDigits.entries) {
      result = result.replaceAll(entry.value, entry.key);
    }
    return result;
  }

  // ============================================================
  // NUMBER FORMATTING
  // ============================================================

  static String formatWithCommas(double number, {int decimals = 0}) {
    final formatter = NumberFormat('#,##0.${'0' * decimals}');
    return formatter.format(number);
  }

  static String formatWithCommasAndPersian(double number, {int decimals = 0}) {
    final formatted = formatWithCommas(number, decimals: decimals);
    return toPersian(formatted);
  }

  static String formatCompact(double number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)} میلیارد';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)} میلیون';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)} هزار';
    }
    return number.toStringAsFixed(0);
  }

  static String formatCompactPersian(double number) {
    return toPersian(formatCompact(number));
  }

  // ============================================================
  // CURRENCY FORMATTING
  // ============================================================

  static String formatCurrency(double amount, {String currency = 'تومان'}) {
    final formatted = formatWithCommas(amount);
    return '$formatted $currency';
  }

  static String formatCurrencyPersian(double amount, {String currency = 'تومان'}) {
    final formatted = formatWithCommasAndPersian(amount);
    return '$formatted $currency';
  }

  static String formatCurrencyWithSign(double amount, {String currency = 'تومان'}) {
    final sign = amount >= 0 ? '+' : '-';
    final formatted = formatWithCommas(amount.abs());
    return '$sign$formatted $currency';
  }

  static String formatCurrencyWithSignPersian(double amount, {String currency = 'تومان'}) {
    final sign = amount >= 0 ? '+' : '-';
    final formatted = formatWithCommasAndPersian(amount.abs());
    return '$sign$formatted $currency';
  }

  // ============================================================
  // PERCENTAGE FORMATTING
  // ============================================================

  static String formatPercentage(double value, {int decimals = 1}) {
    return '${value.toStringAsFixed(decimals)}٪';
  }

  static String formatPercentagePersian(double value, {int decimals = 1}) {
    return '${toPersian(value.toStringAsFixed(decimals))}٪';
  }

  // ============================================================
  // PHONE NUMBER FORMATTING
  // ============================================================

  static String formatPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length == 11) {
      return '${digits.substring(0, 4)} ${digits.substring(4, 7)} ${digits.substring(7)}';
    }
    return phone;
  }

  static String formatPhonePersian(String phone) {
    return toPersian(formatPhone(phone));
  }

  // ============================================================
  // WEIGHT/HEIGHT FORMATTING
  // ============================================================

  static String formatWeight(double weight) {
    return '${weight.toStringAsFixed(1)} کیلوگرم';
  }

  static String formatWeightPersian(double weight) {
    return '${toPersian(weight.toStringAsFixed(1))} کیلوگرم';
  }

  static String formatHeight(double height) {
    return '${height.toStringAsFixed(0)} سانتی‌متر';
  }

  static String formatHeightPersian(double height) {
    return '${toPersian(height.toStringAsFixed(0))} سانتی‌متر';
  }

  // ============================================================
  // DURATION FORMATTING
  // ============================================================

  static String formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours == 0) return '$mins دقیقه';
    if (mins == 0) return '$hours ساعت';
    return '$hours ساعت و $mins دقیقه';
  }

  static String formatDurationPersian(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours == 0) return '${toPersian('$mins')} دقیقه';
    if (mins == 0) return '${toPersian('$hours')} ساعت';
    return '${toPersian('$hours')} ساعت و ${toPersian('$mins')} دقیقه';
  }

  // ============================================================
  // QUANTITY FORMATTING
  // ============================================================

  static String formatQuantity(int quantity, {String unit = 'عدد'}) {
    final formatted = formatWithCommas(quantity.toDouble());
    return '$formatted $unit';
  }

  static String formatQuantityPersian(int quantity, {String unit = 'عدد'}) {
    final formatted = formatWithCommasAndPersian(quantity.toDouble());
    return '$formatted $unit';
  }

  // ============================================================
  // INPUT FORMATTING (for text fields)
  // ============================================================

  static String formatPriceInput(String input) {
    final english = toEnglish(input);
    final digits = english.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return '';
    
    final number = int.parse(digits);
    return toPersian(formatWithCommas(number.toDouble()));
  }

  static String formatPhoneInput(String input) {
    final english = toEnglish(input);
    final digits = english.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return '';
    
    final limited = digits.substring(0, digits.length.clamp(0, 11));
    return toPersian(limited);
  }

  static String formatNumberInput(String input) {
    final english = toEnglish(input);
    final digits = english.replaceAll(RegExp(r'[^\d.]'), '');
    return toPersian(digits);
  }

  // ============================================================
  // VALIDATION HELPERS
  // ============================================================

  static bool isPersianDigit(String char) {
    return persianDigits.values.contains(char);
  }

  static bool containsPersianDigits(String input) {
    return input.split('').any(isPersianDigit);
  }

  static String removeNonDigits(String input) {
    return input.replaceAll(RegExp(r'[^\d]'), '');
  }

  static String removePersianDigits(String input) {
    String result = input;
    for (final digit in persianDigits.values) {
      result = result.replaceAll(digit, '');
    }
    return result;
  }
}

// ============================================================
// EXTENSION ON STRING
// ============================================================

extension PersianStringExtension on String {
  String get toPersianDigits => PersianNumber.toPersian(this);
  String get toArabicDigits => PersianNumber.toArabic(this);
  String get toEnglishDigits => PersianNumber.toEnglish(this);
  String get formatWithCommas => PersianNumber.formatWithCommas(double.tryParse(this) ?? 0);
}

extension PersianDoubleExtension on double {
  String get toPersianDigits => toString().toPersianDigits;
  String get formatWithCommas => PersianNumber.formatWithCommas(this);
  String get formatWithCommasPersian => PersianNumber.formatWithCommasAndPersian(this);
  String get formatCurrency => PersianNumber.formatCurrency(this);
  String get formatCurrencyPersian => PersianNumber.formatCurrencyPersian(this);
}

extension PersianIntExtension on int {
  String get toPersianDigits => toString().toPersianDigits;
  String get formatWithCommas => PersianNumber.formatWithCommas(toDouble());
  String get formatWithCommasPersian => PersianNumber.formatWithCommasAndPersian(toDouble());
}