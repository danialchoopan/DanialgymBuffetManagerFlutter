import 'package:flutter/material.dart';

// ============================================================
// BRAND COLORS
// ============================================================

class AppColors {
  AppColors._();

  // ============================================================
  // PRIMARY COLORS (Athletic Green)
  // ============================================================
  static const Color primary = Color(0xFF1B5E20);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF0D3010);
  static const Color primarySurface = Color(0xFFE8F5E9);
  static const Color primaryContainer = Color(0xFFC8E6C9);

  // ============================================================
  // SECONDARY COLORS (Golden)
  // ============================================================
  static const Color secondary = Color(0xFFFFA000);
  static const Color secondaryLight = Color(0xFFFFC107);
  static const Color secondaryDark = Color(0xFFF57C00);
  static const Color secondarySurface = Color(0xFFFFF8E1);
  static const Color secondaryContainer = Color(0xFFFFECB3);

  // ============================================================
  // ACCENT COLORS
  // ============================================================
  static const Color accentBlue = Color(0xFF1976D2);
  static const Color accentOrange = Color(0xFFF57C00);
  static const Color accentPurple = Color(0xFF7B1FA2);
  static const Color accentTeal = Color(0xFF00796B);
  static const Color accentPink = Color(0xFFC2185B);

  // ============================================================
  // STATUS COLORS
  // ============================================================
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFFFA000);
  static const Color warningLight = Color(0xFFFFF8E1);
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFFFEBEE);
  static const Color info = Color(0xFF1976D2);
  static const Color infoLight = Color(0xFFE3F2FD);

  // ============================================================
  // MEMBERSHIP STATUS COLORS
  // ============================================================
  static const Color membershipActive = Color(0xFF4CAF50);
  static const Color membershipExpiring = Color(0xFFFFA000);
  static const Color membershipExpired = Color(0xFFD32F2F);
  static const Color membershipSuspended = Color(0xFF757575);
  static const Color membershipPending = Color(0xFF1976D2);

  // ============================================================
  // PAYMENT STATUS COLORS
  // ============================================================
  static const Color paymentPaid = Color(0xFF4CAF50);
  static const Color paymentPartial = Color(0xFFFFA000);
  static const Color paymentPending = Color(0xFF1976D2);
  static const Color paymentOverdue = Color(0xFFD32F2F);

  // ============================================================
  // STOCK STATUS COLORS
  // ============================================================
  static const Color stockInStock = Color(0xFF4CAF50);
  static const Color stockLow = Color(0xFFFFA000);
  static const Color stockOut = Color(0xFFD32F2F);

  // ============================================================
  // NEUTRAL COLORS
  // ============================================================
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // ============================================================
  // BACKGROUND & SURFACE
  // ============================================================
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2C2C2C);

  // ============================================================
  // CHART COLORS
  // ============================================================
  static const List<Color> chartColors = [
    Color(0xFF1B5E20),
    Color(0xFFFFA000),
    Color(0xFF1976D2),
    Color(0xFFD32F2F),
    Color(0xFF7B1FA2),
    Color(0xFF00796B),
    Color(0xFFF57C00),
    Color(0xFFC2185B),
  ];

  // ============================================================
  // GRADIENTS
  // ============================================================
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [Color(0xFFD32F2F), Color(0xFFEF5350)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF212121), Color(0xFF424242)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}