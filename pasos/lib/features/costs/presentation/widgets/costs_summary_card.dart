import 'package:flutter/material.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class CostsSummaryCard extends StatelessWidget {
  final double totalFees;
  final double totalPaid;
  final double totalRemaining;

  const CostsSummaryCard({
    super.key,
    required this.totalFees,
    required this.totalPaid,
    required this.totalRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'ملخص المصروفات',
            style: AppTextStyles.arabicHeadline.copyWith(
              fontSize: 20,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('إجمالي الرسوم', totalFees),
              _buildSummaryItem('المبلغ المدفوع', totalPaid),
              _buildSummaryItem('المبلغ المتبقي', totalRemaining),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, double value) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.arabicBody.copyWith(
            color: AppColors.white.withValues(alpha: 0.8),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '${value.toStringAsFixed(2)} جنيه',
          style: AppTextStyles.arabicBody.copyWith(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
