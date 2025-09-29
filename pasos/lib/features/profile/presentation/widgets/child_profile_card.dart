import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../data/models/child_profile_model.dart';

class ChildProfileCard extends StatelessWidget {
  final ChildProfileModel child;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ChildProfileCard({
    super.key,
    required this.child,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  gradient: AppColors.secondaryGradient,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                ),
                child: const Icon(
                  Icons.child_care,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  child.fullName,
                  style: AppTextStyles.arabicHeadline.copyWith(fontSize: 18),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: AppColors.secondary),
                onPressed: onEdit,
                tooltip: 'تعديل',
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: AppColors.error),
                onPressed: onDelete,
                tooltip: 'حذف',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildInfoRow('العمر', _calculateAge(child.dateOfBirth)),
          _buildInfoRow('الجنس', _translateGender(child.gender)),
          if (child.schoolName != null)
            _buildInfoRow('المدرسة', child.schoolName!),
          if (child.grade != null) _buildInfoRow('الصف', child.grade!),
          const SizedBox(height: AppSpacing.sm),
          _buildHealthSummary(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxs),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: AppTextStyles.arabicBody.copyWith(
              fontSize: 12,
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
          Text(value, style: AppTextStyles.arabicBody.copyWith(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildHealthSummary() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Row(
        children: [
          Icon(Icons.medical_services, size: 16, color: AppColors.secondary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            'فصيلة الدم: ${child.healthData.bloodType}',
            style: AppTextStyles.arabicBody.copyWith(fontSize: 10),
          ),
          const Spacer(),
          Text(
            '${child.healthData.height} سم | ${child.healthData.weight} كجم',
            style: AppTextStyles.arabicBody.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }

  String _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return '$age سنة';
  }

  String _translateGender(String gender) {
    return gender == 'Male' ? 'ذكر' : 'أنثى';
  }
}
