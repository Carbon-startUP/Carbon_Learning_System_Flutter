import 'package:flutter/material.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(Icons.person, size: 40, color: AppColors.primary),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'مرحبا بك',
          style: AppTextStyles.arabicHeadline.copyWith(fontSize: 32),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'سجل دخولك للمتابعة',
          style: AppTextStyles.arabicBody.copyWith(
            color: AppColors.black.withOpacity(0.6),
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
