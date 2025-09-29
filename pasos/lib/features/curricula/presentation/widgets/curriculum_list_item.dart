import 'package:flutter/material.dart';
import 'package:pasos/features/curricula/data/models/curriculum_model.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class CurriculumListItem extends StatelessWidget {
  final CurriculumModel curriculum;
  final VoidCallback onTap;

  const CurriculumListItem({
    super.key,
    required this.curriculum,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.horizontalPadding,
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          gradient: AppColors.primaryGradient,
        ),
        child: Row(
          children: [
            Icon(
              curriculum.fileType == 'pdf'
                  ? Icons.picture_as_pdf
                  : Icons.description,
              color: AppColors.white,
              size: 40,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curriculum.title,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.white,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    '${curriculum.subject} - ${curriculum.grade}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white.withOpacity(0.8),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}
