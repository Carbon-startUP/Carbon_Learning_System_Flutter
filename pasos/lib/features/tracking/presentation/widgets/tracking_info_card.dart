import 'package:flutter/material.dart';
import 'package:pasos/features/tracking/data/models/tracking_status_model.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class TrackingInfoCard extends StatelessWidget {
  final TrackingStatusModel status;

  const TrackingInfoCard({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background.withValues(alpha: 0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'بيانات السوار للطالب: ${status.studentName}',
              style: AppTextStyles.titleMedium,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'معرف السوار: ${status.braceletId}',
                  style: AppTextStyles.bodyMedium,
                ),
                Row(
                  children: [
                    Text(
                      '${(status.batteryLevel * 100).toInt()}%',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(
                      Icons.battery_full,
                      color: AppColors.success,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
