import 'encryption_helper.dart';

class PasswordHasher {
  PasswordHasher._();

  static String hash(String password) {
    return EncryptionHelper.hashPassword(password);
  }

  static bool verify(String password, String storedHash) {
    return EncryptionHelper.verifyPassword(password, storedHash);
  }

  static bool isPasswordStrong(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  static String generateTemporaryPassword() {
    final chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*';
    final random = DateTime.now().millisecondsSinceEpoch;
    final tempPassword = StringBuffer();
    for (var i = 0; i < 12; i++) {
      tempPassword.write(chars[(random + i) % chars.length]);
    }
    return tempPassword.toString();
  }
}