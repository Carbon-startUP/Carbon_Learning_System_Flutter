import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/theme/app_text_styles.dart';

class CategoryFilterWidget extends StatelessWidget {
  final String? selectedCategory;
  final Function(String?) onCategorySelected;

  const CategoryFilterWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<Map<String, String>> categories = const [
    {'value': 'مساحات عمل', 'label': 'مساحات عمل'},
    {'value': 'أماكن ترفيهية', 'label': 'أماكن ترفيهية'},
    {'value': 'دورات تدريبية', 'label': 'دورات تدريبية'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category['value'];

          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: FilterChip(
              label: Text(
                category['label']!,
                style: AppTextStyles.labelMedium.copyWith(
                  fontFamily: 'RPT',
                  color: isSelected
                      ? AppColors.white
                      : AppColors.whiteWithOpacity,
                ),
              ),
              selected: isSelected,
              onSelected: (_) => onCategorySelected(category['value']),
              backgroundColor: AppColors.primaryWithOpacity,
              selectedColor: AppColors.primary,
              checkmarkColor: AppColors.white,
              side: BorderSide(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.whiteWithOpacity,
                width: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
