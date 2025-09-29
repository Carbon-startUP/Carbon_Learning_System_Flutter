import 'package:flutter/material.dart';
import 'package:pasos/features/schedule/data/models/schedule_model.dart';
import 'package:pasos/features/schedule/presentation/widgets/class_item_widget.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class ScheduleDayWidget extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleDayWidget({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient.scale(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        childrenPadding: const EdgeInsets.all(AppSpacing.sm),
        title: Text(
          schedule.dayName,
          style: AppTextStyles.arabicBody.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${schedule.classes.length} حصص',
          style: AppTextStyles.arabicBody.copyWith(
            fontSize: 14,
            color: AppColors.black.withValues(alpha: 0.7),
          ),
        ),
        children: schedule.classes.map((classItem) {
          return ClassItemWidget(classItem: classItem);
        }).toList(),
      ),
    );
  }
}
