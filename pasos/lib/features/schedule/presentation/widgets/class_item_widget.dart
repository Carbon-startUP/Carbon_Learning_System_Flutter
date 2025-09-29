import 'package:flutter/material.dart';
import 'package:pasos/features/schedule/data/models/schedule_model.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class ClassItemWidget extends StatelessWidget {
  final ClassModel classItem;

  const ClassItemWidget({super.key, required this.classItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            ),
            child: Center(
              child: Text(
                classItem.periodNumber.toString(),
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classItem.subjectName,
                  style: AppTextStyles.arabicBody.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  classItem.teacherName,
                  style: AppTextStyles.arabicBody.copyWith(
                    fontSize: 14,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${classItem.startTime} - ${classItem.endTime}',
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                'قاعة ${classItem.roomNumber}',
                style: AppTextStyles.arabicBody.copyWith(
                  fontSize: 12,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
