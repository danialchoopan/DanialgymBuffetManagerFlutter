import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../themes/dimensions.dart';

// ============================================================
// CUSTOM APP BAR
// ============================================================

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final Widget? bottom;
  final double? bottomHeight;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = false,
    this.bottom,
    this.bottomHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom != null ? (bottomHeight ?? 56) : 0),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: showBackButton,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      centerTitle: centerTitle,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomHeight ?? 56),
              child: bottom!,
            )
          : null,
    );
  }
}

// ============================================================
// CUSTOM BUTTON
// ============================================================

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isOutlined;
  final bool isSmall;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isOutlined = false,
    this.isSmall = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = isSmall ? AppButton.heightSM : AppButton.heightLG;

    if (isOutlined) {
      return SizedBox(
        width: width,
        height: height ?? effectiveHeight,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? AppColors.primary,
            side: BorderSide(
              color: backgroundColor ?? AppColors.primary,
            ),
          ),
          child: _buildChild(),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height ?? effectiveHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? AppColors.white,
        ),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            textColor ?? AppColors.white,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppIconSize.md),
          const SizedBox(width: AppSpacing.sm),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}

// ============================================================
// CUSTOM TEXT FIELD
// ============================================================

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? errorText;
  final String? helperText;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool dense;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final int maxLines;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.errorText,
    this.helperText,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.dense = false,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      maxLines: maxLines,
      maxLength: maxLength,
      style: AppTypography.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        helperText: helperText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixIconTap,
                child: Icon(suffixIcon),
              )
            : null,
        contentPadding: dense ? AppInput.contentPaddingDense : null,
        isDense: dense,
      ),
    );
  }
}

// ============================================================
// CUSTOM CARD
// ============================================================

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final double? elevation;
  final bool showBorder;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius = AppBorderRadius.md,
    this.onTap,
    this.elevation,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? AppElevation.sm,
      margin: margin ?? AppCard.margin,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: showBorder
            ? const BorderSide(color: AppColors.gray200)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding ?? AppCard.padding,
          child: child,
        ),
      ),
    );
  }
}

// ============================================================
// STAT CARD
// ============================================================

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final String? change;
  final bool? isPositiveChange;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
    this.change,
    this.isPositiveChange,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                ),
                child: Icon(icon, color: color, size: AppIconSize.lg),
              ),
              if (change != null) ...[
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: (isPositiveChange ?? true)
                        ? AppColors.successLight
                        : AppColors.errorLight,
                    borderRadius: BorderRadius.circular(AppBorderRadius.xs),
                  ),
                  child: Text(
                    change!,
                    style: AppTypography.labelSmall.copyWith(
                      color: (isPositiveChange ?? true)
                          ? AppColors.success
                          : AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            value,
            style: AppTypography.stat.copyWith(color: AppColors.gray900),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            title,
            style: AppTypography.statLabel.copyWith(
              color: AppColors.gray600,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle!,
              style: AppTypography.caption.copyWith(
                color: AppColors.gray500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ============================================================
// STATUS BADGE
// ============================================================

class StatusBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool isSmall;
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.textColor = AppColors.white,
    this.isSmall = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? AppSpacing.sm : AppSpacing.md,
        vertical: isSmall ? AppSpacing.xs : AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppChip.borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: isSmall ? 12 : 14, color: textColor),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            text,
            style: (isSmall ? AppTypography.badge : AppTypography.labelMedium)
                .copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EMPTY STATE
// ============================================================

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: AppColors.gray300,
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              title,
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.gray700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.gray500,
              ),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null) ...[
              const SizedBox(height: AppSpacing.xl),
              CustomButton(
                text: buttonText!,
                onPressed: onButtonPressed,
                icon: Icons.add,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================
// LOADING OVERLAY
// ============================================================

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black54,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppBorderRadius.md),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                    if (message != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        message!,
                        style: AppTypography.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// SECTION HEADER
// ============================================================

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  final bool showDivider;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.gray900,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle!,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (action != null) action!,
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: AppSpacing.md),
          const Divider(),
        ],
      ],
    );
  }
}

// ============================================================
// LIST ITEM
// ============================================================

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;
  final EdgeInsetsGeometry? contentPadding;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showDivider = true,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: leading,
          title: Text(
            title,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.gray900,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.gray500,
                  ),
                )
              : null,
          trailing: trailing,
          onTap: onTap,
          contentPadding: contentPadding,
        ),
        if (showDivider)
          const Divider(
            height: 1,
            indent: AppList.leadingWidth,
          ),
      ],
    );
  }
}