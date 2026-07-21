class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Gym Buffet Manager';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Comprehensive Gym & Buffet Management System';

  // Storage Keys
  static const String hiveBoxName = 'gym_buffet_box';
  static const String settingsBox = 'settings_box';
  static const String cacheBox = 'cache_box';
  static const String authBox = 'auth_box';

  // Database
  static const String dbName = 'gym_buffet_database.db';
  static const int dbVersion = 1;

  // Biometric
  static const String biometricKey = 'biometric_enabled';
  static const String pinKey = 'user_pin';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';
  static const String monthYearFormat = 'MMMM yyyy';

  // Currency
  static const String defaultCurrency = 'USD';
  static const String currencySymbol = '\$';
}