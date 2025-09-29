import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../data/models/user_profile_model.dart';

class ProfileInfoCard extends StatelessWidget {
  final UserProfileModel profile;

  const ProfileInfoCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.fullName,
                      style: AppTextStyles.arabicHeadline.copyWith(
                        color: AppColors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'رقم البطاقة: ${profile.cardIdNumber}',
                      style: AppTextStyles.arabicBody.copyWith(
                        fontSize: 12,
                        color: AppColors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _buildInfoRow(
            Icons.cake,
            'تاريخ الميلاد',
            _formatDate(profile.dateOfBirth),
          ),
          _buildInfoRow(
            Icons.people,
            'الجنس',
            _translateGender(profile.gender),
          ),
          _buildInfoRow(Icons.phone, 'رقم الهاتف', profile.phoneNumber),
          _buildInfoRow(Icons.email, 'البريد الإلكتروني', profile.email),
          _buildInfoRow(Icons.location_on, 'العنوان', profile.address),
          if (profile.lastUpdated != null)
            _buildInfoRow(
              Icons.update,
              'آخر تحديث',
              _formatDate(profile.lastUpdated!),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.white.withOpacity(0.6)),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '$label: ',
            style: AppTextStyles.arabicBody.copyWith(
              fontSize: 14,
              color: AppColors.white.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.arabicBody.copyWith(
                fontSize: 14,
                color: AppColors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _translateGender(String gender) {
    return gender == 'Male' ? 'ذكر' : 'أنثى';
  }
}
