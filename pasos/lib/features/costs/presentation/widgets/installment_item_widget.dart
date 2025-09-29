import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';
import '../../data/models/installment_model.dart';

class InstallmentItemWidget extends StatelessWidget {
  final InstallmentModel installment;

  const InstallmentItemWidget({super.key, required this.installment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
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
                      'إجمالي الرسوم: ${installment.totalFees.toStringAsFixed(2)} جنيه',
                      style: AppTextStyles.arabicBody.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'المبلغ المدفوع: ${installment.paidAmount.toStringAsFixed(2)} جنيه',
                      style: AppTextStyles.arabicBody.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'المبلغ المتبقي: ${installment.remainingAmount.toStringAsFixed(2)} جنيه',
                      style: AppTextStyles.arabicBody.copyWith(
                        color: installment.remainingAmount > 0
                            ? AppColors.warning
                            : AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Divider(color: AppColors.primary.withValues(alpha: 0.2)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'طريقة الدفع',
                    style: AppTextStyles.arabicBody.copyWith(
                      fontSize: 12,
                      color: AppColors.black.withValues(alpha: 0.6),
                    ),
                  ),
                  Text(
                    installment.paymentMethod,
                    style: AppTextStyles.arabicBody,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تاريخ الدفع',
                    style: AppTextStyles.arabicBody.copyWith(
                      fontSize: 12,
                      color: AppColors.black.withValues(alpha: 0.6),
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(installment.paymentDate),
                    style: AppTextStyles.arabicBody,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تاريخ الاستحقاق',
                    style: AppTextStyles.arabicBody.copyWith(
                      fontSize: 12,
                      color: AppColors.black.withValues(alpha: 0.6),
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(installment.dueDate),
                    style: AppTextStyles.arabicBody.copyWith(
                      color:
                          installment.dueDate.isBefore(DateTime.now()) &&
                              installment.remainingAmount > 0
                          ? AppColors.error
                          : AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (installment.isPaid)
            Container(
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
              ),
              child: Text(
                'تم السداد',
                style: AppTextStyles.arabicBody.copyWith(
                  color: AppColors.success,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
