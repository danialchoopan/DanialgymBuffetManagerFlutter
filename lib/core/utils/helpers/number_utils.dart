// Placeholder for number_utils.dart
// Will be implemented with number formatting and parsing utilities
class NumberUtils {
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  static String formatCompact(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }

  static double parseDouble(String value, [double defaultValue = 0]) {
    return double.tryParse(value) ?? defaultValue;
  }

  static int parseInt(String value, [int defaultValue = 0]) {
    return int.tryParse(value) ?? defaultValue;
  }

  static String formatPercentage(double value, {int decimals = 1}) {
    return '${(value * 100).toStringAsFixed(decimals)}%';
  }
}