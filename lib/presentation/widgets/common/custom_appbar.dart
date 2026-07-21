import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.centerTitle = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTypography.titleLarge.copyWith(
          color: foregroundColor ?? AppColors.white,
        ),
      ),
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: showBackButton,
      backgroundColor: backgroundColor ?? AppColors.primaryLight,
      foregroundColor: foregroundColor ?? AppColors.white,
      elevation: elevation,
      centerTitle: centerTitle,
    );
  }
}