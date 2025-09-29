import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/theme/app_spacing.dart';

class EmptyChatWidget extends StatelessWidget {
  final VoidCallback? onHistoryTap;
  final VoidCallback? onNewChatTap;

  const EmptyChatWidget({super.key, this.onHistoryTap, this.onNewChatTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                gradient: AppColors.secondaryGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 64,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'ابدأ محادثة جديدة',
              style: AppTextStyles.arabicHeadline.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'اطرح أسئلتك أو أرسل ملفاتك\nوسأكون سعيداً لمساعدتك',
              style: AppTextStyles.arabicBody.copyWith(
                color: AppColors.blackWithOpacity,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (onHistoryTap != null || onNewChatTap != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (onHistoryTap != null) ...[
                    OutlinedButton.icon(
                      onPressed: onHistoryTap,
                      icon: Icon(Icons.history, color: AppColors.secondary),
                      label: Text(
                        'المحادثات السابقة',
                        style: AppTextStyles.arabicBody.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.secondary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusLarge,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                  ],
                  if (onNewChatTap != null)
                    ElevatedButton.icon(
                      onPressed: onNewChatTap,
                      icon: Icon(Icons.add, color: AppColors.white),
                      label: Text(
                        'محادثة جديدة',
                        style: AppTextStyles.arabicBody.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusLarge,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      children: [
        Text(
          'اقتراحات للبدء:',
          style: AppTextStyles.arabicBody.copyWith(
            color: AppColors.blackWithOpacity,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _buildQuickActionChip('اسأل عن البرمجة'),
            _buildQuickActionChip('ساعدني في الرياضيات'),
            _buildQuickActionChip('تحليل مستند'),
            _buildQuickActionChip('وصف صورة'),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryWithOpacity,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: AppTextStyles.arabicBody.copyWith(
          color: AppColors.primary,
          fontSize: 12,
        ),
      ),
    );
  }
}
