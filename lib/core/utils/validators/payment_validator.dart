// Placeholder for payment_validator.dart
// Will be implemented with validation logic for payment fields
class PaymentValidator {
  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }
    final amount = double.tryParse(value.trim());
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  static String? validatePaymentMethod(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Payment method is required';
    }
    return null;
  }

  static String? validateReference(String? value) {
    if (value != null && value.trim().length > 100) {
      return 'Reference must be less than 100 characters';
    }
    return null;
  }
}