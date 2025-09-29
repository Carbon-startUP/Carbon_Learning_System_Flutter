import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/tracking/presentation/cubit/tracking_cubit.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class TrackingControlPanel extends StatelessWidget {
  final bool isTrackingActive;

  const TrackingControlPanel({super.key, required this.isTrackingActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: ElevatedButton.icon(
        onPressed: () {
          context.read<TrackingCubit>().toggleTracking(isTrackingActive);
        },
        icon: Icon(
          isTrackingActive
              ? Icons.stop_circle_outlined
              : Icons.play_circle_outline,
        ),
        label: Text(
          isTrackingActive ? 'إيقاف التتبع' : 'تفعيل التتبع',
          style: AppTextStyles.buttonText,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isTrackingActive
              ? AppColors.error
              : AppColors.success,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}
