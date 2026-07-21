import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class EncryptionHelper {
  EncryptionHelper._();

  static const String _saltCharacters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  static const int _saltLength = 16;

  static String generateSalt() {
    final random = Random.secure();
    return List.generate(_saltLength, (_) => _saltCharacters[random.nextInt(_saltCharacters.length)]).join();
  }

  static String hashData(String data, String salt) {
    final bytes = utf8.encode(data + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static bool verifyData(String data, String hashedData, String salt) {
    final hashedInput = hashData(data, salt);
    return hashedInput == hashedData;
  }

  static String encryptSimple(String data, String key) {
    final bytes = utf8.encode(data);
    final keyBytes = utf8.encode(key);
    final encrypted = <int>[];

    for (var i = 0; i < bytes.length; i++) {
      encrypted.add(bytes[i] ^ keyBytes[i % keyBytes.length]);
    }

    return base64Encode(Uint8List.fromList(encrypted));
  }

  static String decryptSimple(String encryptedData, String key) {
    final bytes = base64Decode(encryptedData);
    final keyBytes = utf8.encode(key);
    final decrypted = <int>[];

    for (var i = 0; i < bytes.length; i++) {
      decrypted.add(bytes[i] ^ keyBytes[i % keyBytes.length]);
    }

    return utf8Decode(Uint8List.fromList(decrypted));
  }

  static String generateRandomString(int length) {
    final random = Random.secure();
    return List.generate(length, (_) => _saltCharacters[random.nextInt(_saltCharacters.length)]).join();
  }

  static String generateApiKey() {
    return generateRandomString(32);
  }

  static String hashPassword(String password) {
    final salt = generateSalt();
    final hashed = hashData(password, salt);
    return '$salt:$hashed';
  }

  static bool verifyPassword(String password, String storedHash) {
    final parts = storedHash.split(':');
    if (parts.length != 2) return false;
    final salt = parts[0];
    final hash = parts[1];
    return verifyData(password, hash, salt);
  }
}