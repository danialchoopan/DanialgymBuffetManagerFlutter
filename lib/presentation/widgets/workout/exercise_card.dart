import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';
import '../../../core/constants/workout_constants.dart';

class ExerciseCard extends StatelessWidget {
  final String name;
  final String muscleGroup;
  final String equipment;
  final String difficultyLevel;
  final bool isCompound;
  final String? imagePath;
  final VoidCallback? onTap;

  const ExerciseCard({
    super.key,
    required this.name,
    required this.muscleGroup,
    required this.equipment,
    required this.difficultyLevel,
    this.isCompound = false,
    this.imagePath,
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.fitness_center,
                  color: AppColors.primaryLight,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: AppTypography.titleMedium,
                          ),
                        ),
                        if (isCompound)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Compound',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.accentPurple,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildTag(
                          WorkoutConstants.muscleGroupDisplayNames[muscleGroup] ?? muscleGroup,
                          AppColors.accentTeal,
                        ),
                        const SizedBox(width: 8),
                        _buildTag(
                          equipment,
                          AppColors.secondaryLight,
                        ),
                        const SizedBox(width: 8),
                        _buildTag(
                          difficultyLevel,
                          _getDifficultyColor(difficultyLevel),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.grey400),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: AppTypography.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getDifficultyColor(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return AppColors.accentGreen;
      case 'intermediate':
        return AppColors.secondaryLight;
      case 'advanced':
        return AppColors.accentRed;
      default:
        return AppColors.grey500;
    }
  }
}

class WorkoutProgramCard extends StatelessWidget {
  final String name;
  final String type;
  final String difficultyLevel;
  final int durationWeeks;
  final int daysPerWeek;
  final String? description;
  final VoidCallback? onTap;

  const WorkoutProgramCard({
    super.key,
    required this.name,
    required this.type,
    required this.difficultyLevel,
    required this.durationWeeks,
    required this.daysPerWeek,
    this.description,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: AppTypography.titleMedium,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      WorkoutConstants.programTypeDisplayNames[type] ?? type,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ),
                ],
              ),
              if (description != null) ...[
                const SizedBox(height: 8),
                Text(
                  description!,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.grey600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(
                    Icons.calendar_today,
                    '$durationWeeks weeks',
                  ),
                  const SizedBox(width: 12),
                  _buildInfoChip(
                    Icons.fitness_center,
                    '$daysPerWeek days/week',
                  ),
                  const SizedBox(width: 12),
                  _buildInfoChip(
                    Icons.signal_cellular_alt,
                    difficultyLevel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.grey500),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.grey600,
          ),
        ),
      ],
    );
  }
}

class ProgressChart extends StatelessWidget {
  final String title;
  final List<double> data;
  final List<String> labels;
  final Color chartColor;

  const ProgressChart({
    super.key,
    required this.title,
    required this.data,
    required this.labels,
    this.chartColor = AppColors.primaryLight,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'Chart will be implemented with fl_chart',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}