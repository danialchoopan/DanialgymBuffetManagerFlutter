import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  // ============================================================
  // LIGHT THEME
  // ============================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Use Vazirmatn as default font via Google Fonts
      fontFamily: GoogleFonts.vazirmatn().fontFamily,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.secondaryDark,
        tertiary: AppColors.accentBlue,
        onTertiary: AppColors.white,
        error: AppColors.error,
        onError: AppColors.white,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.gray900,
        onSurfaceVariant: AppColors.gray600,
        outline: AppColors.gray300,
        outlineVariant: AppColors.gray200,
        shadow: AppColors.black,
        background: AppColors.backgroundLight,
        onBackground: AppColors.gray900,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // Text Theme
      textTheme: GoogleFonts.vazirmatnTextTheme().copyWith(
        displayLarge: GoogleFonts.vazirmatn(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: AppColors.gray900,
        ),
        headlineLarge: GoogleFonts.vazirmatn(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
        headlineMedium: GoogleFonts.vazirmatn(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
        titleLarge: GoogleFonts.vazirmatn(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
        titleMedium: GoogleFonts.vazirmatn(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.gray900,
        ),
        bodyLarge: GoogleFonts.vazirmatn(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.gray900,
        ),
        bodyMedium: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.gray700,
        ),
        labelLarge: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.gray600,
        ),
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        titleTextStyle: GoogleFonts.vazirmatn(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.white,
          size: 24,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryDark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.gray500,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Cards
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.white,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          textStyle: GoogleFonts.vazirmatn(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(color: AppColors.primary, width: 1),
          textStyle: GoogleFonts.vazirmatn(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.vazirmatn(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
      ),

      // Text Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.gray300,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.gray300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        labelStyle: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.gray600,
        ),
        hintStyle: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.gray400,
        ),
      ),

      // Dialogs
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColors.white,
        elevation: 8,
        titleTextStyle: GoogleFonts.vazirmatn(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
        contentTextStyle: GoogleFonts.vazirmatn(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.gray700,
        ),
      ),

      // Snack Bar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gray800,
        contentTextStyle: GoogleFonts.vazirmatn(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray100,
        selectedColor: AppColors.primary,
        labelStyle: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: const BorderSide(color: AppColors.gray300),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.gray200,
        thickness: 1,
        space: 1,
        indent: 16,
        endIndent: 16,
      ),

      // List Tile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        titleTextStyle: GoogleFonts.vazirmatn(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.gray900,
        ),
        subtitleTextStyle: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.gray600,
        ),
        iconColor: AppColors.gray600,
      ),
    );
  }

  // ============================================================
  // DARK THEME
  // ============================================================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Use Vazirmatn as default font via Google Fonts
      fontFamily: GoogleFonts.vazirmatn().fontFamily,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.black,
        primaryContainer: AppColors.primaryDark,
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        onSecondary: AppColors.black,
        secondaryContainer: AppColors.secondaryDark,
        onSecondaryContainer: AppColors.secondaryLight,
        tertiary: AppColors.accentBlue,
        onTertiary: AppColors.white,
        error: AppColors.error,
        onError: AppColors.white,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.white,
        onSurfaceVariant: AppColors.gray400,
        outline: AppColors.gray600,
        outlineVariant: AppColors.gray700,
        shadow: AppColors.black,
        background: AppColors.backgroundDark,
        onBackground: AppColors.white,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // Text Theme
      textTheme: GoogleFonts.vazirmatnTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.vazirmatn(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        headlineLarge: GoogleFonts.vazirmatn(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        headlineMedium: GoogleFonts.vazirmatn(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        titleLarge: GoogleFonts.vazirmatn(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        titleMedium: GoogleFonts.vazirmatn(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        bodyLarge: GoogleFonts.vazirmatn(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
        bodyMedium: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.gray400,
        ),
        labelLarge: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.gray400,
        ),
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.white,
        titleTextStyle: GoogleFonts.vazirmatn(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.white,
          size: 24,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.surfaceDark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.gray500,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Cards
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.cardDark,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.black,
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
      ),

      // Text Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray800,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.gray600,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.gray600,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.primaryLight,
            width: 2,
          ),
        ),
        labelStyle: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.gray400,
        ),
        hintStyle: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.gray500,
        ),
      ),

      // Dialogs
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColors.surfaceDark,
        elevation: 8,
        titleTextStyle: GoogleFonts.vazirmatn(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        contentTextStyle: GoogleFonts.vazirmatn(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.gray300,
        ),
      ),

      // Snack Bar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gray200,
        contentTextStyle: GoogleFonts.vazirmatn(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray800,
        selectedColor: AppColors.primaryLight,
        labelStyle: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: const BorderSide(color: AppColors.gray600),
      ),

      // List Tile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        titleTextStyle: GoogleFonts.vazirmatn(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
        subtitleTextStyle: GoogleFonts.vazirmatn(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.gray400,
        ),
        iconColor: AppColors.gray400,
      ),
    );
  }
}