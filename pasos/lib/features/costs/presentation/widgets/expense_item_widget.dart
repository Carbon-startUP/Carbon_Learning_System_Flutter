import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';
import '../../data/models/expense_model.dart';

class ExpenseItemWidget extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseItemWidget({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusSmall,
                            ),
                          ),
                          child: Text(
                            expense.category,
                            style: AppTextStyles.arabicBody.copyWith(
                              fontSize: 12,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                        if (expense.isPaid) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusSmall,
                              ),
                            ),
                            child: Text(
                              'مدفوع',
                              style: AppTextStyles.arabicBody.copyWith(
                                fontSize: 12,
                                color: AppColors.success,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      expense.reason,
                      style: AppTextStyles.arabicBody.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'المبلغ: ${expense.amount.toStringAsFixed(2)} جنيه',
                      style: AppTextStyles.arabicBody.copyWith(
                        color: AppColors.secondaryAlt,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تاريخ الاستحقاق: ${DateFormat('dd/MM/yyyy').format(expense.dueDate)}',
                style: AppTextStyles.arabicBody.copyWith(
                  fontSize: 12,
                  color:
                      expense.dueDate.isBefore(DateTime.now()) &&
                          !expense.isPaid
                      ? AppColors.error
                      : AppColors.black,
                ),
              ),
              if (!expense.isPaid && expense.dueDate.isBefore(DateTime.now()))
                Icon(Icons.warning, size: 16, color: AppColors.error),
            ],
          ),
        ],
      ),
    );
  }
}
