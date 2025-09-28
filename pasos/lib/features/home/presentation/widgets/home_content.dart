import 'package:flutter/material.dart';
import 'package:pasos/core/navigation/app_router.dart';
import 'package:pasos/features/home/presentation/widgets/feature_card.dart';
import 'package:pasos/shared/theme/app_colors.dart';
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
            BuildFeatureCard(
              context: context,
              icon: Icons.chat_bubble_outlined,
              title: 'المساعد الذكي',
              description: 'تحدث مع المساعد الذكي',
              gradientColors: [AppColors.primary, AppColors.secondary],
              onTap: () => Navigator.pushNamed(context, AppRouter.aiChat),
            ),
            BuildFeatureCard(
              context: context,
              icon: Icons.person,
              title: 'حسابي',
              description: 'إدارة معلوماتي الشخصية والصحية',
              gradientColors: [AppColors.primary, AppColors.secondary],
              onTap: () => Navigator.pushNamed(context, AppRouter.profile),
            ),
            BuildFeatureCard(
              context: context,
              icon: Icons.account_balance_wallet,
              title: 'المصروفات والأقساط',
              description: 'متابعة المصروفات والأقساط المالية',
              gradientColors: [AppColors.primary, AppColors.secondary],
              onTap: () => Navigator.pushNamed(context, AppRouter.costs),
            ),
            BuildFeatureCard(
              context: context,
              icon: Icons.play_circle_outline,
              title: 'الترفيه والكرتون',
              description: 'مشاهدة أفلام الكرتون والقصص التعليمية',
              gradientColors: [AppColors.primary, AppColors.secondary],
              onTap: () =>
                  Navigator.pushNamed(context, AppRouter.entertainment),
            ),
            BuildFeatureCard(
              context: context,
              icon: Icons.campaign,
              title: 'الاعلانات والعروض',
              description: 'متابعة الاعلانات والعروض',
              gradientColors: [AppColors.primary, AppColors.secondary],
              onTap: () =>
                  Navigator.pushNamed(context, AppRouter.advertisements),
            ),
          ],
        ),
      ),
    );
  }
}
