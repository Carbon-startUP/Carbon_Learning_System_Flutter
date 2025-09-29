import 'package:flutter/material.dart';
import 'package:pasos/features/exams/data/models/exam_result_model.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class ExamResultCard extends StatelessWidget {
  final ExamResultModel result;

  const ExamResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            result.subjectName,
            style: AppTextStyles.arabicBody.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الدرجة: ${result.score}/${result.totalScore}',
                style: AppTextStyles.arabicBody.copyWith(
                  color: AppColors.white,
                ),
              ),
              Text(
                'التقدير: ${result.grade}',
                style: AppTextStyles.arabicBody.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'تاريخ الامتحان: ${result.examDate.day}/${result.examDate.month}/${result.examDate.year}',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
