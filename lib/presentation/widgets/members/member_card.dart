import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String membershipType;
  final String membershipStatus;
  final String? photoPath;
  final DateTime? membershipEndDate;
  final VoidCallback? onTap;

  const MemberCard({
    super.key,
    required this.name,
    required this.membershipType,
    required this.membershipStatus,
    this.photoPath,
    this.membershipEndDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primaryLight.withOpacity(0.1),
                backgroundImage: photoPath != null ? NetworkImage(photoPath!) : null,
                child: photoPath == null
                    ? Text(
                        name.substring(0, 2).toUpperCase(),
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.primaryLight,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      membershipType,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (membershipStatus.toLowerCase()) {
      case 'active':
        backgroundColor = AppColors.activeMembership;
        textColor = AppColors.white;
        displayText = 'Active';
        break;
      case 'expired':
        backgroundColor = AppColors.expiredMembership;
        textColor = AppColors.white;
        displayText = 'Expired';
        break;
      case 'suspended':
        backgroundColor = AppColors.suspendedMembership;
        textColor = AppColors.white;
        displayText = 'Suspended';
        break;
      default:
        backgroundColor = AppColors.grey300;
        textColor = AppColors.grey700;
        displayText = membershipStatus;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayText,
        style: AppTypography.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class PaymentStatusBadge extends StatelessWidget {
  final String status;

  const PaymentStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (status.toLowerCase()) {
      case 'paid':
        backgroundColor = AppColors.paid;
        textColor = AppColors.white;
        icon = Icons.check_circle;
        break;
      case 'pending':
        backgroundColor = AppColors.pending;
        textColor = AppColors.white;
        icon = Icons.pending;
        break;
      case 'overdue':
        backgroundColor = AppColors.overdue;
        textColor = AppColors.white;
        icon = Icons.error;
        break;
      case 'partial':
        backgroundColor = AppColors.partial;
        textColor = AppColors.white;
        icon = Icons.partially_paid;
        break;
      default:
        backgroundColor = AppColors.grey300;
        textColor = AppColors.grey700;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            status.toUpperCase(),
            style: AppTypography.labelSmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}