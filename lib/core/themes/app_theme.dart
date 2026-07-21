import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'typography.dart';
import 'dimensions.dart';

class AppTheme {
  AppTheme._();

  // ============================================================
  // LIGHT THEME
  // ============================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppTypography.persianFont,

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

      // App Bar
      appBarTheme: AppBarTheme(
        elevation: AppElevation.none,
        centerTitle: false,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        titleTextStyle: AppTypography.headlineMedium.copyWith(
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.white,
          size: AppIconSize.lg,
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
        elevation: AppElevation.lg,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.normal,
        ),
      ),

      // Cards
      cardTheme: CardTheme(
        elevation: AppElevation.sm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
        ),
        color: AppColors.white,
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(AppButton.minWidth, AppButton.heightLG),
          padding: AppButton.paddingLG,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppButton.borderRadius),
          ),
          elevation: AppElevation.sm,
          textStyle: AppTypography.titleMedium.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(AppButton.minWidth, AppButton.heightLG),
          padding: AppButton.paddingLG,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppButton.borderRadius),
          ),
          side: const BorderSide(color: AppColors.primary, width: 1),
          textStyle: AppTypography.titleMedium.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: AppButton.paddingMD,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppButton.borderRadius),
          ),
          textStyle: AppTypography.titleMedium.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.primary,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: AppElevation.lg,
        shape: CircleBorder(),
      ),

      // Text Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: AppInput.contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppInput.borderRadius),
          borderSide: const BorderSide(
            color: AppColors.gray300,
            width: AppInput.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppInput.borderRadius),
          borderSide: const BorderSide(
            color: AppColors.gray300,
            width: AppInput.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppInput.borderRadius),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: AppInput.borderWidthFocus,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppInput.borderRadius),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: AppInput.borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppInput.borderRadius),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: AppInput.borderWidthFocus,
          ),
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.gray600,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.gray400,
        ),
        prefixIconColor: AppColors.gray500,
        suffixIconColor: AppColors.gray500,
      ),

      // Dialogs
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDialog.borderRadius),
        ),
        backgroundColor: AppColors.white,
        elevation: AppDialog.elevation,
        titleTextStyle: AppTypography.headlineMedium.copyWith(
          color: AppColors.gray900,
        ),
        contentTextStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.gray700,
        ),
      ),

      // Bottom Sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppBottomSheet.borderRadius),
          ),
        ),
        elevation: AppBottomSheet.elevation,
        modalBackgroundColor: AppColors.white,
        modalBarrierColor: Colors.black54,
      ),

      // Snack Bar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gray800,
        contentTextStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSnackBar.borderRadius),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: AppSnackBar.elevation,
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray100,
        selectedColor: AppColors.primary,
        disabledColor: AppColors.gray200,
        labelStyle: AppTypography.labelLarge,
        secondaryLabelStyle: AppTypography.labelLarge.copyWith(
          color: AppColors.white,
        ),
        padding: AppChip.padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppChip.borderRadius),
        ),
        side: const BorderSide(color: AppColors.gray300),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.gray200,
        thickness: AppDivider.thickness,
        space: AppDivider.height,
        indent: AppDivider.indent,
        endIndent: AppDivider.endIndent,
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.white;
          }
          return AppColors.gray400;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.gray300;
        }),
      ),

      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.white;
        }),
        side: const BorderSide(color: AppColors.gray400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppCheckbox.borderRadius),
        ),
      ),

      // Radio
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.gray400;
        }),
      ),

      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.gray200,
        circularTrackColor: AppColors.gray200,
      ),

      // Tab Bar
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.white70,
        indicatorColor: AppColors.white,
        labelStyle: AppTypography.titleMedium.copyWith(
          color: AppColors.white,
        ),
        unselectedLabelStyle: AppTypography.titleMedium.copyWith(
          color: AppColors.white70,
        ),
      ),

      // Drawer
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.white,
        elevation: AppElevation.xxl,
        shape: RoundedRectangleBorder(),
      ),

      // List Tile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        titleTextStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.gray900,
        ),
        subtitleTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.gray600,
        ),
        leadingAndTrailingTextStyle: AppTypography.bodyLarge,
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
      fontFamily: AppTypography.persianFont,

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

      // App Bar
      appBarTheme: AppBarTheme(
        elevation: AppElevation.none,
        centerTitle: false,
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.white,
        titleTextStyle: AppTypography.headlineMedium.copyWith(
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.white,
          size: AppIconSize.lg,
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
        elevation: AppElevation.lg,
      ),

      // Cards
      cardTheme: CardTheme(
        elevation: AppElevation.sm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
        ),
        color: AppColors.cardDark,
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.black,
          minimumSize: const Size(AppButton.minWidth, AppButton.heightLG),
          padding: AppButton.paddingLG,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppButton.borderRadius),
          ),
          elevation: AppElevation.sm,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          minimumSize: const Size(AppButton.minWidth, AppButton.heightLG),
          padding: AppButton.paddingLG,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppButton.borderRadius),
          ),
          side: const BorderSide(color: AppColors.primaryLight, width: 1),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          padding: AppButton.paddingMD,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppButton.borderRadius),
          ),
        ),
      ),

      // Text Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray800,
        contentPadding: AppInput.contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppInput.borderRadius),
          borderSide: const BorderSide(
            color: AppColors.gray600,
            width: AppInput.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppInput.borderRadius),
          borderSide: const BorderSide(
            color: AppColors.gray600,
            width: AppInput.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppInput.borderRadius),
          borderSide: const BorderSide(
            color: AppColors.primaryLight,
            width: AppInput.borderWidthFocus,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppInput.borderRadius),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: AppInput.borderWidth,
          ),
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.gray400,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.gray500,
        ),
      ),

      // Dialogs
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDialog.borderRadius),
        ),
        backgroundColor: AppColors.surfaceDark,
        elevation: AppDialog.elevation,
        titleTextStyle: AppTypography.headlineMedium.copyWith(
          color: AppColors.white,
        ),
        contentTextStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.gray300,
        ),
      ),

      // Bottom Sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppBottomSheet.borderRadius),
          ),
        ),
        elevation: AppBottomSheet.elevation,
      ),

      // Snack Bar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gray200,
        contentTextStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSnackBar.borderRadius),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray800,
        selectedColor: AppColors.primaryLight,
        labelStyle: AppTypography.labelLarge.copyWith(
          color: AppColors.white,
        ),
        padding: AppChip.padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppChip.borderRadius),
        ),
        side: const BorderSide(color: AppColors.gray600),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.gray700,
        thickness: AppDivider.thickness,
        space: AppDivider.height,
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.black;
          }
          return AppColors.gray500;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryLight;
          }
          return AppColors.gray600;
        }),
      ),

      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryLight,
        linearTrackColor: AppColors.gray700,
      ),

      // Tab Bar
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.gray400,
        indicatorColor: AppColors.primaryLight,
        labelStyle: AppTypography.titleMedium.copyWith(
          color: AppColors.white,
        ),
        unselectedLabelStyle: AppTypography.titleMedium.copyWith(
          color: AppColors.gray400,
        ),
      ),

      // Drawer
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.surfaceDark,
        elevation: AppElevation.xxl,
      ),

      // List Tile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        titleTextStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.white,
        ),
        subtitleTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.gray400,
        ),
        iconColor: AppColors.gray400,
      ),
    );
  }
}