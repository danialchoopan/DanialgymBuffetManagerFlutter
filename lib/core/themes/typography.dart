import 'package:flutter/material.dart';
import 'package:vazirmatn/vazirmatn.dart';

// ============================================================
// TYPOGRAPHY SYSTEM WITH VAZIRMATN FONT
// ============================================================

class AppTypography {
  AppTypography._();

  // ============================================================
  // FONT FAMILIES
  // ============================================================
  static const String persianFont = 'Vazirmatn';
  static const String englishFont = 'Roboto';

  // ============================================================
  // FONT WEIGHTS
  // ============================================================
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // ============================================================
  // DISPLAY STYLES
  // ============================================================
  static TextStyle displayLarge = Vazirmatn.style(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
    height: 1.3,
  );

  static TextStyle displayMedium = Vazirmatn.style(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    height: 1.3,
  );

  static TextStyle displaySmall = Vazirmatn.style(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    height: 1.3,
  );

  // ============================================================
  // HEADLINE STYLES
  // ============================================================
  static TextStyle headlineLarge = Vazirmatn.style(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle headlineMedium = Vazirmatn.style(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle headlineSmall = Vazirmatn.style(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  // ============================================================
  // TITLE STYLES
  // ============================================================
  static TextStyle titleLarge = Vazirmatn.style(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static TextStyle titleMedium = Vazirmatn.style(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.5,
  );

  static TextStyle titleSmall = Vazirmatn.style(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // ============================================================
  // BODY STYLES
  // ============================================================
  static TextStyle bodyLarge = Vazirmatn.style(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.6,
  );

  static TextStyle bodyMedium = Vazirmatn.style(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.6,
  );

  static TextStyle bodySmall = Vazirmatn.style(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.6,
  );

  // ============================================================
  // LABEL STYLES
  // ============================================================
  static TextStyle labelLarge = Vazirmatn.style(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle labelMedium = Vazirmatn.style(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle labelSmall = Vazirmatn.style(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ============================================================
  // SPECIAL STYLES
  // ============================================================
  static TextStyle price = Vazirmatn.style(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle priceSmall = Vazirmatn.style(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle priceLarge = Vazirmatn.style(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle stat = Vazirmatn.style(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.2,
  );

  static TextStyle statLabel = Vazirmatn.style(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle badge = Vazirmatn.style(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
  );

  static TextStyle caption = Vazirmatn.style(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.4,
  );

  // ============================================================
  // HELPER METHODS
  // ============================================================

  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
}