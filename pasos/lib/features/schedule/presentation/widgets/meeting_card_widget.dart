import 'package:flutter/material.dart';
import 'package:pasos/features/schedule/data/models/meeting_model.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';
import 'package:intl/intl.dart';

class MeetingCardWidget extends StatelessWidget {
  final MeetingModel meeting;

  const MeetingCardWidget({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient.scale(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meeting.subject,
                        style: AppTextStyles.arabicBody.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        'مع ${meeting.teacherName}',
                        style: AppTextStyles.arabicBody.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(meeting.status),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              meeting.description,
              style: AppTextStyles.arabicBody.copyWith(
                fontSize: 14,
                color: AppColors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.white.withOpacity(0.7),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  DateFormat('yyyy/MM/dd').format(meeting.meetingDate),
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(width: AppSpacing.md),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: AppColors.white.withOpacity(0.7),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(meeting.timeSlot, style: AppTextStyles.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(MeetingStatus status) {
    Color color;
    String text;

    switch (status) {
      case MeetingStatus.pending:
        color = AppColors.warning;
        text = 'قيد الانتظار';
        break;
      case MeetingStatus.approved:
        color = AppColors.success;
        text = 'مؤكد';
        break;
      case MeetingStatus.rejected:
        color = AppColors.error;
        text = 'مرفوض';
        break;
      case MeetingStatus.completed:
        color = AppColors.info;
        text = 'مكتمل';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: AppTextStyles.arabicBody.copyWith(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
