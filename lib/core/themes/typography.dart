import 'package:flutter/material.dart';

// ============================================================
// TYPOGRAPHY SYSTEM
// ============================================================

class AppTypography {
  AppTypography._();

  // ============================================================
  // FONT FAMILIES
  // ============================================================
  static const String persianFont = 'Vazirmatn';
  static const String englishFont = 'Roboto';
  static const String monoFont = 'FiraCode';

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
  static const TextStyle displayLarge = TextStyle(
    fontFamily: persianFont,
    fontSize: 34,
    fontWeight: bold,
    letterSpacing: 0.25,
    height: 1.3,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: persianFont,
    fontSize: 28,
    fontWeight: bold,
    letterSpacing: 0,
    height: 1.3,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: persianFont,
    fontSize: 24,
    fontWeight: bold,
    letterSpacing: 0,
    height: 1.3,
  );

  // ============================================================
  // HEADLINE STYLES
  // ============================================================
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: persianFont,
    fontSize: 22,
    fontWeight: semiBold,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: persianFont,
    fontSize: 20,
    fontWeight: semiBold,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: persianFont,
    fontSize: 18,
    fontWeight: semiBold,
    letterSpacing: 0,
    height: 1.4,
  );

  // ============================================================
  // TITLE STYLES
  // ============================================================
  static const TextStyle titleLarge = TextStyle(
    fontFamily: persianFont,
    fontSize: 16,
    fontWeight: semiBold,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: persianFont,
    fontSize: 14,
    fontWeight: medium,
    letterSpacing: 0.1,
    height: 1.5,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: persianFont,
    fontSize: 12,
    fontWeight: medium,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // ============================================================
  // BODY STYLES
  // ============================================================
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: persianFont,
    fontSize: 14,
    fontWeight: regular,
    letterSpacing: 0.25,
    height: 1.6,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: persianFont,
    fontSize: 12,
    fontWeight: regular,
    letterSpacing: 0.25,
    height: 1.6,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: persianFont,
    fontSize: 11,
    fontWeight: regular,
    letterSpacing: 0.4,
    height: 1.6,
  );

  // ============================================================
  // LABEL STYLES
  // ============================================================
  static const TextStyle labelLarge = TextStyle(
    fontFamily: persianFont,
    fontSize: 12,
    fontWeight: medium,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: persianFont,
    fontSize: 11,
    fontWeight: medium,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: persianFont,
    fontSize: 10,
    fontWeight: medium,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ============================================================
  // SPECIAL STYLES
  // ============================================================
  static const TextStyle price = TextStyle(
    fontFamily: persianFont,
    fontSize: 16,
    fontWeight: bold,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle priceSmall = TextStyle(
    fontFamily: persianFont,
    fontSize: 12,
    fontWeight: semiBold,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle priceLarge = TextStyle(
    fontFamily: persianFont,
    fontSize: 20,
    fontWeight: bold,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle stat = TextStyle(
    fontFamily: persianFont,
    fontSize: 28,
    fontWeight: bold,
    letterSpacing: 0,
    height: 1.2,
  );

  static const TextStyle statLabel = TextStyle(
    fontFamily: persianFont,
    fontSize: 11,
    fontWeight: regular,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static const TextStyle badge = TextStyle(
    fontFamily: persianFont,
    fontSize: 10,
    fontWeight: semiBold,
    letterSpacing: 0.5,
    height: 1.2,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: persianFont,
    fontSize: 10,
    fontWeight: regular,
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