import 'package:flutter/material.dart';

// ============================================================
// SPACING SYSTEM (8px grid)
// ============================================================

class AppSpacing {
  AppSpacing._();

  // Base unit: 8px
  static const double unit = 8;

  // Small
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;

  // Medium
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  // Large
  static const double xxxl = 40;
  static const double xxxxl = 48;
  static const double xxxxxl = 56;
  static const double xxxxxxl = 64;

  // Padding
  static const EdgeInsets paddingXS = EdgeInsets.all(4);
  static const EdgeInsets paddingSM = EdgeInsets.all(8);
  static const EdgeInsets paddingMD = EdgeInsets.all(12);
  static const EdgeInsets paddingLG = EdgeInsets.all(16);
  static const EdgeInsets paddingXL = EdgeInsets.all(24);
  static const EdgeInsets paddingXXL = EdgeInsets.all(32);

  // Horizontal Padding
  static const EdgeInsets paddingHorizontalSM = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets paddingHorizontalMD = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets paddingHorizontalLG = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets paddingHorizontalXL = EdgeInsets.symmetric(horizontal: 24);

  // Vertical Padding
  static const EdgeInsets paddingVerticalSM = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets paddingVerticalMD = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets paddingVerticalLG = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets paddingVerticalXL = EdgeInsets.symmetric(vertical: 24);

  // Margin
  static const EdgeInsets marginSM = EdgeInsets.all(8);
  static const EdgeInsets marginMD = EdgeInsets.all(12);
  static const EdgeInsets marginLG = EdgeInsets.all(16);
  static const EdgeInsets marginXL = EdgeInsets.all(24);

  // SizedBox helpers
  static const SizedBox heightXS = SizedBox(height: 4);
  static const SizedBox heightSM = SizedBox(height: 8);
  static const SizedBox heightMD = SizedBox(height: 12);
  static const SizedBox heightLG = SizedBox(height: 16);
  static const SizedBox heightXL = SizedBox(height: 24);
  static const SizedBox heightXXL = SizedBox(height: 32);

  static const SizedBox widthXS = SizedBox(width: 4);
  static const SizedBox widthSM = SizedBox(width: 8);
  static const SizedBox widthMD = SizedBox(width: 12);
  static const SizedBox widthLG = SizedBox(width: 16);
  static const SizedBox widthXL = SizedBox(width: 24);
}

// ============================================================
// BORDER RADIUS
// ============================================================

class AppBorderRadius {
  AppBorderRadius._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double circular = 100;

  static BorderRadius radiusXS = BorderRadius.circular(xs);
  static BorderRadius radiusSM = BorderRadius.circular(sm);
  static BorderRadius radiusMD = BorderRadius.circular(md);
  static BorderRadius radiusLG = BorderRadius.circular(lg);
  static BorderRadius radiusXL = BorderRadius.circular(xl);
  static BorderRadius radiusCircular = BorderRadius.circular(circular);

  static BorderRadius topXS = BorderRadius.vertical(top: Radius.circular(xs));
  static BorderRadius topSM = BorderRadius.vertical(top: Radius.circular(sm));
  static BorderRadius topMD = BorderRadius.vertical(top: Radius.circular(md));
  static BorderRadius topLG = BorderRadius.vertical(top: Radius.circular(lg));

  static BorderRadius bottomXS = BorderRadius.vertical(bottom: Radius.circular(xs));
  static BorderRadius bottomSM = BorderRadius.vertical(bottom: Radius.circular(sm));
  static BorderRadius bottomMD = BorderRadius.vertical(bottom: Radius.circular(md));
  static BorderRadius bottomLG = BorderRadius.vertical(bottom: Radius.circular(lg));
}

// ============================================================
// ELEVATION & SHADOW
// ============================================================

class AppElevation {
  AppElevation._();

  static const double none = 0;
  static const double xs = 1;
  static const double sm = 2;
  static const double md = 4;
  static const double lg = 8;
  static const double xl = 12;
  static const double xxl = 16;

  static List<BoxShadow> get shadowXS => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get shadowSM => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowMD => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowLG => [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> get shadowXL => [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
}

// ============================================================
// ANIMATION DURATIONS
// ============================================================

class AppDuration {
  AppDuration._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 700);

  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration dialogAnimation = Duration(milliseconds: 200);
  static const Duration bottomSheetAnimation = Duration(milliseconds: 350);
}

// ============================================================
// ICON SIZES
// ============================================================

class AppIconSize {
  AppIconSize._();

  static const double xs = 12;
  static const double sm = 16;
  static const double md = 20;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 40;
  static const double xxxl = 48;
  static const double xxxxl = 64;
}

// ============================================================
// TOUCH TARGET
// ============================================================

class AppTouchTarget {
  AppTouchTarget._();

  static const double minimum = 44;
  static const double comfortable = 48;
  static const double large = 56;
}

// ============================================================
// CARD SPECIFICATIONS
// ============================================================

class AppCard {
  AppCard._();

  static const double elevation = 2;
  static const double elevationHover = 8;
  static const double borderRadius = 12;
  static const EdgeInsets padding = EdgeInsets.all(16);
  static const EdgeInsets paddingSM = EdgeInsets.all(12);
  static const EdgeInsets paddingLG = EdgeInsets.all(20);
  static const EdgeInsets margin = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const EdgeInsets marginSM = EdgeInsets.symmetric(horizontal: 12, vertical: 4);
}

// ============================================================
// BUTTON SPECIFICATIONS
// ============================================================

class AppButton {
  AppButton._();

  static const double heightSM = 32;
  static const double heightMD = 40;
  static const double heightLG = 48;
  static const double heightXL = 56;

  static const double minWidth = 64;
  static const double borderRadius = 8;
  static const double borderRadiusLG = 12;
  static const double iconSize = 20;
  static const double iconSpacing = 8;

  static const EdgeInsets paddingSM = EdgeInsets.symmetric(horizontal: 12, vertical: 6);
  static const EdgeInsets paddingMD = EdgeInsets.symmetric(horizontal: 16, vertical: 10);
  static const EdgeInsets paddingLG = EdgeInsets.symmetric(horizontal: 24, vertical: 14);
  static const EdgeInsets paddingXL = EdgeInsets.symmetric(horizontal: 32, vertical: 16);
}

// ============================================================
// INPUT SPECIFICATIONS
// ============================================================

class AppInput {
  AppInput._();

  static const double height = 56;
  static const double heightDense = 48;
  static const double borderRadius = 8;
  static const double iconSize = 20;
  static const double borderWidth = 1;
  static const double borderWidthFocus = 2;

  static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 14);
  static const EdgeInsets contentPaddingDense = EdgeInsets.symmetric(horizontal: 12, vertical: 10);
}

// ============================================================
// LIST SPECIFICATIONS
// ============================================================

class AppList {
  AppList._();

  static const double itemHeight = 64;
  static const double itemHeightDense = 56;
  static const double itemHeightLarge = 80;
  static const double dividerHeight = 1;
  static const double avatarSize = 40;
  static const double avatarSizeSmall = 32;
  static const double avatarSizeLarge = 56;
  static const double leadingWidth = 56;
  static const double trailingWidth = 48;
}

// ============================================================
// BOTTOM NAVIGATION SPECIFICATIONS
// ============================================================

class AppBottomNav {
  AppBottomNav._();

  static const double height = 64;
  static const double iconSize = 24;
  static const double selectedIconSize = 26;
  static const double labelFontSize = 12;
  static const double itemMinWidth = 48;
  static const double itemMaxWidth = 128;
  static const int maxItems = 5;
}

// ============================================================
// APP BAR SPECIFICATIONS
// ============================================================

class AppBar {
  AppBar._();

  static const double height = 56;
  static const double heightLarge = 64;
  static const double iconSize = 24;
  static const double titleFontSize = 18;
  static const EdgeInsets titlePadding = EdgeInsets.symmetric(horizontal: 16);
}

// ============================================================
// DIALOG SPECIFICATIONS
// ============================================================

class AppDialog {
  AppDialog._();

  static const double borderRadius = 16;
  static const double maxWidth = 400;
  static const double elevation = 8;
  static const EdgeInsets padding = EdgeInsets.all(24);
  static const EdgeInsets titlePadding = EdgeInsets.fromLTRB(24, 24, 24, 8);
  static const EdgeInsets contentPadding = EdgeInsets.fromLTRB(24, 8, 24, 8);
  static const EdgeInsets actionsPadding = EdgeInsets.fromLTRB(24, 8, 24, 24);
}

// ============================================================
// BOTTOM SHEET SPECIFICATIONS
// ============================================================

class AppBottomSheet {
  AppBottomSheet._();

  static const double borderRadius = 16;
  static const double elevation = 12;
  static const double handleWidth = 40;
  static const double handleHeight = 4;
  static const double handleTopPadding = 12;
  static const double handleBottomPadding = 8;
  static const double headerHeight = 56;
  static const EdgeInsets contentPadding = EdgeInsets.all(16);
}

// ============================================================
// SNACK BAR SPECIFICATIONS
// ============================================================

class AppSnackBar {
  AppSnackBar._();

  static const double borderRadius = 8;
  static const double elevation = 6;
  static const Duration duration = Duration(seconds: 3);
  static const Duration durationLong = Duration(seconds: 5);
  static const EdgeInsets margin = EdgeInsets.all(16);
  static const double maxWidth = 560;
}

// ============================================================
// CHIP SPECIFICATIONS
// ============================================================

class AppChip {
  AppChip._();

  static const double height = 32;
  static const double heightSmall = 24;
  static const double borderRadius = 16;
  static const double avatarSize = 20;
  static const double iconSize = 16;
  static const double borderWidth = 1;
  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 12, vertical: 4);
  static const EdgeInsets paddingSmall = EdgeInsets.symmetric(horizontal: 8, vertical: 2);
}

// ============================================================
// BADGE SPECIFICATIONS
// ============================================================

class AppBadge {
  AppBadge._();

  static const double size = 18;
  static const double sizeSmall = 14;
  static const double sizeLarge = 24;
  static const double fontSize = 10;
  static const double fontSizeSmall = 8;
  static const double borderWidth = 2;
  static const double minWidth = 18;
}

// ============================================================
// PROGRESS INDICATOR SPECIFICATIONS
// ============================================================

class AppProgress {
  AppProgress._();

  static const double sizeSmall = 16;
  static const double sizeMedium = 24;
  static const double sizeLarge = 32;
  static const double sizeXL = 48;
  static const double strokeWidth = 2;
  static const double strokeWidthLarge = 3;
}

// ============================================================
// DIVIDER SPECIFICATIONS
// ============================================================

class AppDivider {
  AppDivider._();

  static const double height = 1;
  static const double thickness = 1;
  static const double indent = 16;
  static const double endIndent = 16;
  static const Color color = Color(0xFFE0E0E0);
}

// ============================================================
// SPECIFICATIONS
// ============================================================

class AppSwitch {
  AppSwitch._();

  static const double width = 52;
  static const double height = 32;
  static const double thumbSize = 24;
  static const double trackSize = 16;
}

class AppCheckbox {
  AppCheckbox._();

  static const double size = 20;
  static const double borderWidth = 2;
  static const double borderRadius = 4;
}

class AppRadio {
  AppRadio._();

  static const double size = 20;
  static const double borderWidth = 2;
  static const double innerSize = 10;
}

// ============================================================
// GRID SPECIFICATIONS
// ============================================================

class AppGrid {
  AppGrid._();

  static const double spacing = 16;
  static const double runSpacing = 16;
  static const double minCrossAxisExtent = 150;
  static const double maxCrossAxisExtent = 200;
  static const double childAspectRatio = 1;
  static const double childAspectRatioWide = 1.5;
  static const double childAspectRatioTall = 0.75;
}

// ============================================================
// TOOLTIP SPECIFICATIONS
// ============================================================

class AppTooltip {
  AppTooltip._();

  static const double borderRadius = 8;
  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  static const Duration waitDuration = Duration(milliseconds: 500);
  static const Duration showDuration = Duration(seconds: 2);
}

// ============================================================
// LOADING SPECIFICATIONS
// ============================================================

class AppLoading {
  AppLoading._();

  static const double size = 40;
  static const double sizeSmall = 24;
  static const double sizeLarge = 60;
  static const double strokeWidth = 3;
  static const Duration minDuration = Duration(milliseconds: 500);
}

// ============================================================
// AVATAR SPECIFICATIONS
// ============================================================

class AppAvatar {
  AppAvatar._();

  static const double sizeXS = 24;
  static const double sizeSM = 32;
  static const double sizeMD = 40;
  static const double sizeLG = 56;
  static const double sizeXL = 72;
  static const double sizeXXL = 96;
  static const double borderWidth = 2;
  static const double borderRadius = 100;
}

// ============================================================
// FAB SPECIFICATIONS
// ============================================================

class AppFab {
  AppFab._();

  static const double size = 56;
  static const double sizeMini = 40;
  static const double iconSize = 24;
  static const double elevation = 6;
  static const double elevationHover = 12;
  static const double borderRadius = 16;
}

// ============================================================
// SEARCH BAR SPECIFICATIONS
// ============================================================

class AppSearchBar {
  AppSearchBar._();

  static const double height = 56;
  static const double iconSize = 24;
  static const double borderRadius = 28;
  static const double elevation = 2;
  static const double elevationFocused = 4;
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 16);
}