class ErrorMessages {
  ErrorMessages._();

  // General Errors
  static const String unexpectedError = 'An unexpected error occurred. Please try again.';
  static const String networkError = 'Network error. Please check your connection.';
  static const String timeoutError = 'Request timed out. Please try again.';
  static const String cancelledError = 'Request was cancelled.';

  // Database Errors
  static const String databaseError = 'Database error occurred. Please restart the app.';
  static const String databaseInitError = 'Failed to initialize database.';
  static const String databaseInsertError = 'Failed to save data.';
  static const String databaseUpdateError = 'Failed to update data.';
  static const String databaseDeleteError = 'Failed to delete data.';
  static const String databaseQueryError = 'Failed to retrieve data.';

  // Authentication Errors
  static const String authenticationError = 'Authentication failed.';
  static const String invalidCredentials = 'Invalid username or password.';
  static const String accountLocked = 'Account is locked. Please contact administrator.';
  static const String biometricError = 'Biometric authentication failed.';
  static const String biometricNotAvailable = 'Biometric authentication is not available on this device.';
  static const String pinRequired = 'Please enter your PIN.';
  static const String invalidPin = 'Invalid PIN. Please try again.';

  // Validation Errors
  static const String requiredField = 'This field is required.';
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String invalidPhone = 'Please enter a valid phone number.';
  static const String invalidPassword = 'Password must be at least 8 characters.';
  static const String passwordMismatch = 'Passwords do not match.';
  static const String invalidDate = 'Please enter a valid date.';
  static const String invalidAmount = 'Please enter a valid amount.';
  static const String invalidNumber = 'Please enter a valid number.';

  // Member Errors
  static const String memberNotFound = 'Member not found.';
  static const String memberAlreadyExists = 'A member with this email or phone already exists.';
  static const String membershipExpired = 'Member\'s membership has expired.';
  static const String membershipInactive = 'Member\'s membership is inactive.';
  static const String paymentOverdue = 'Member has overdue payments.';

  // Workout Errors
  static const String workoutNotFound = 'Workout program not found.';
  static const String exerciseNotFound = 'Exercise not found.';
  static const String programAlreadyAssigned = 'This program is already assigned to the member.';

  // Buffet Errors
  static const String productNotFound = 'Product not found.';
  static const String productOutOfStock = 'Product is out of stock.';
  static const String insufficientStock = 'Insufficient stock for this product.';
  static const String categoryNotFound = 'Category not found.';
  static const String orderNotFound = 'Order not found.';

  // Accounting Errors
  static const String paymentFailed = 'Payment processing failed.';
  static const String transactionNotFound = 'Transaction not found.';
  static const String insufficientFunds = 'Insufficient funds.';
  static const String reportGenerationFailed = 'Failed to generate report.';

  // Staff Errors
  static const String staffNotFound = 'Staff member not found.';
  static const String staffAlreadyExists = 'A staff member with this username already exists.';
  static const String unauthorizedAccess = 'You do not have permission to access this feature.';

  // File Errors
  static const String fileNotFound = 'File not found.';
  static const String fileAccessError = 'Unable to access file.';
  static const String fileSaveError = 'Failed to save file.';
  static const String imagePickError = 'Failed to select image.';

  // Backup Errors
  static const String backupFailed = 'Backup failed.';
  static const String restoreFailed = 'Restore failed.';
  static const String backupCorrupted = 'Backup file is corrupted.';

  // Export Errors
  static const String exportFailed = 'Export failed.';
  static const String printFailed = 'Print job failed.';

  // Success Messages
  static const String saveSuccess = 'Data saved successfully.';
  static const String updateSuccess = 'Data updated successfully.';
  static const String deleteSuccess = 'Data deleted successfully.';
  static const String loginSuccess = 'Login successful.';
  static const String logoutSuccess = 'Logged out successfully.';
  static const String backupSuccess = 'Backup created successfully.';
  static const String restoreSuccess = 'Data restored successfully.';
  static const String exportSuccess = 'Export completed successfully.';
  static const String paymentSuccess = 'Payment processed successfully.';
  static const String checkInSuccess = 'Checked in successfully.';
  static const String checkOutSuccess = 'Checked out successfully.';
}