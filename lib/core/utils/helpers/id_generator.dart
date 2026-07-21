// Placeholder for id_generator.dart
// Will be implemented with ID generation utilities
import 'package:uuid/uuid.dart';

class IdGenerator {
  static const _uuid = Uuid();

  static String generate() => _uuid.v4();
  static String generateShort() => _uuid.v4().substring(0, 8);

  static String generateOrderNumber() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final timePart = '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
    final randomPart = _uuid.v4().substring(0, 4).toUpperCase();
    return 'ORD$datePart$timePart$randomPart';
  }

  static String generateInvoiceNumber() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = _uuid.v4().substring(0, 4).toUpperCase();
    return 'INV$datePart$randomPart';
  }

  static String generateMemberId() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = _uuid.v4().substring(0, 4).toUpperCase();
    return 'MEM$datePart$randomPart';
  }
}