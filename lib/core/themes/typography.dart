import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ============================================================
// TYPOGRAPHY SYSTEM WITH PERSIAN FONT SUPPORT
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
  static TextStyle displayLarge = GoogleFonts.vazirmatn(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
    height: 1.3,
  );

  static TextStyle displayMedium = GoogleFonts.vazirmatn(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    height: 1.3,
  );

  static TextStyle displaySmall = GoogleFonts.vazirmatn(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    height: 1.3,
  );

  // ============================================================
  // HEADLINE STYLES
  // ============================================================
  static TextStyle headlineLarge = GoogleFonts.vazirmatn(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle headlineMedium = GoogleFonts.vazirmatn(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle headlineSmall = GoogleFonts.vazirmatn(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  // ============================================================
  // TITLE STYLES
  // ============================================================
  static TextStyle titleLarge = GoogleFonts.vazirmatn(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static TextStyle titleMedium = GoogleFonts.vazirmatn(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.5,
  );

  static TextStyle titleSmall = GoogleFonts.vazirmatn(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // ============================================================
  // BODY STYLES
  // ============================================================
  static TextStyle bodyLarge = GoogleFonts.vazirmatn(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.6,
  );

  static TextStyle bodyMedium = GoogleFonts.vazirmatn(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.6,
  );

  static TextStyle bodySmall = GoogleFonts.vazirmatn(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.6,
  );

  // ============================================================
  // LABEL STYLES
  // ============================================================
  static TextStyle labelLarge = GoogleFonts.vazirmatn(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle labelMedium = GoogleFonts.vazirmatn(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle labelSmall = GoogleFonts.vazirmatn(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ============================================================
  // SPECIAL STYLES
  // ============================================================
  static TextStyle price = GoogleFonts.vazirmatn(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle priceSmall = GoogleFonts.vazirmatn(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle priceLarge = GoogleFonts.vazirmatn(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle stat = GoogleFonts.vazirmatn(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.2,
  );

  static TextStyle statLabel = GoogleFonts.vazirmatn(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle badge = GoogleFonts.vazirmatn(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
  );

  static TextStyle caption = GoogleFonts.vazirmatn(
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