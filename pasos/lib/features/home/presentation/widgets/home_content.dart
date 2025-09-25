import 'package:flutter/material.dart';
import 'package:pasos/core/navigation/app_router.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';
import 'package:pasos/shared/theme/app_spacing.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [SliverToBoxAdapter(child: _buildWelcomeSection(context))],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'مرحبا بك',
              style: AppTextStyles.arabicHeadline,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              'ماذا تريد أن تفعل اليوم؟',
              style: AppTextStyles.arabicBody,
              textAlign: TextAlign.right,
            ),
            SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.aiChat);
              },
              child: Text('المساعد الذكي', style: AppTextStyles.arabicBody),
            ),
          ],
        ),
      ),
    );
  }
}
