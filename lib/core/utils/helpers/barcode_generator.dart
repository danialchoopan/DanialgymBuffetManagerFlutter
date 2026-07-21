// Placeholder for barcode_generator.dart
// Will be implemented with barcode generation utilities
class BarcodeGenerator {
  static String generateSKU(String prefix, int number) {
    return '$prefix-${number.toString().padLeft(6, '0')}';
  }

  static String generateBarcode() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(0, 12);
  }

  static bool validateBarcode(String barcode) {
    return barcode.length == 12 || barcode.length == 13;
  }
}