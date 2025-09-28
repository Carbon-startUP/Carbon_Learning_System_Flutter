import 'package:flutter/material.dart';
import 'package:pasos/core/navigation/app_router.dart';
import 'package:pasos/features/entertainment/data/datasources/entertainment_datasource.dart';
import 'package:pasos/features/entertainment/presentation/widgets/entertainment_category_card.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';
import 'package:pasos/shared/theme/app_spacing.dart';

class EntertainmentPage extends StatelessWidget {
  const EntertainmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = EntertainmentDatasource.getCategories();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الترفيه والكرتون',
          style: AppTextStyles.arabicHeadline.copyWith(fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اختر نوع الكرتون المفضل لك',
                  style: AppTextStyles.arabicBody.copyWith(fontSize: 18),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: AppSpacing.lg),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.0,
                          crossAxisCount: 1,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return EntertainmentCategoryCard(
                        title: category.title,
                        backgroundImage: category.backgroundImage,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.entertainmentCategory,
                            arguments: {
                              'categoryTitle': category.title,
                              'videos': category.videos,
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
