import 'package:flutter/material.dart';
import 'package:pasos/core/navigation/app_router.dart';
import 'package:pasos/features/home/presentation/widgets/feature_card.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class ParentContent extends StatelessWidget {
  const ParentContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('مرحباً بك يا ولي الأمر', style: AppTextStyles.arabicHeadline),
            const SizedBox(height: AppSpacing.xs),
            Text('يمكنك متابعة أبنائك من هنا', style: AppTextStyles.arabicBody),
            const SizedBox(height: AppSpacing.xl),
            BuildFeatureCard(
              context: context,
              icon: Icons.location_on_outlined,
              title: 'تتبع الأبناء',
              description: 'عرض مسار الطالب وتفعيل خدمة التتبع',
              gradientColors: const [AppColors.primary, AppColors.secondary],
              onTap: () => Navigator.pushNamed(context, AppRouter.tracking),
            ),
            BuildFeatureCard(
              context: context,
              icon: Icons.payment,
              title: 'المصروفات والأقساط',
              description: 'متابعة المصروفات والأقساط المالية',
              gradientColors: const [AppColors.primary, AppColors.secondary],
              onTap: () => Navigator.pushNamed(context, AppRouter.costs),
            ),
            BuildFeatureCard(
              context: context,
              icon: Icons.school_outlined,
              title: 'نتائج الامتحانات',
              description: 'عرض نتائج الامتحانات الدراسية',
              gradientColors: const [AppColors.primary, AppColors.secondary],
              onTap: () => Navigator.pushNamed(context, AppRouter.examResults),
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
              icon: Icons.play_circle_outline,
              title: 'الترفيه والكرتون',
              description: 'مشاهدة أفلام الكرتون والقصص التعليمية',
              gradientColors: [AppColors.primary, AppColors.secondary],
              onTap: () =>
                  Navigator.pushNamed(context, AppRouter.entertainment),
            ),
            BuildFeatureCard(
              context: context,
              icon: Icons.calendar_today,
              title: 'الجدول الدراسي',
              description: 'عرض الجدول الدراسي وطلب مواعيد مع المعلمين',
              gradientColors: [AppColors.primary, AppColors.secondary],
              onTap: () => Navigator.pushNamed(context, AppRouter.schedule),
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
