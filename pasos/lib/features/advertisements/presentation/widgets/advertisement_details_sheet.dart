import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../data/models/advertisement_model.dart';

class AdvertisementDetailsSheet extends StatelessWidget {
  final AdvertisementModel advertisement;
  final VoidCallback onSubscribe;

  const AdvertisementDetailsSheet({
    super.key,
    required this.advertisement,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSpacing.radiusXLarge),
            topRight: Radius.circular(AppSpacing.radiusXLarge),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildHandle(), _buildImage(), _buildContent(context)],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.whiteWithOpacity,
        borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        image: DecorationImage(
          image: NetworkImage(advertisement.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            advertisement.titleAr,
            style: AppTextStyles.headlineSmall.copyWith(fontFamily: 'RPT'),
          ),
          const SizedBox(height: AppSpacing.xs),
          _buildInfoRow(Icons.location_on, advertisement.locationAr),
          const SizedBox(height: AppSpacing.xs),
          _buildInfoRow(Icons.category, advertisement.category),
          const SizedBox(height: AppSpacing.md),
          Text(
            advertisement.descriptionAr,
            style: AppTextStyles.bodyMedium.copyWith(
              fontFamily: 'RPT',
              color: AppColors.whiteWithOpacity,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildPriceSection(),
          const SizedBox(height: AppSpacing.lg),
          _buildSubscribeButton(context),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.secondary),
        const SizedBox(width: AppSpacing.xs),
        Text(
          text,
          style: AppTextStyles.bodySmall.copyWith(
            fontFamily: 'RPT',
            color: AppColors.whiteWithOpacity,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryWithOpacity,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'السعر',
            style: AppTextStyles.titleMedium.copyWith(fontFamily: 'RPT'),
          ),
          Text(
            '${advertisement.price} ${advertisement.priceUnit}',
            style: AppTextStyles.headlineSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: advertisement.isSubscribed
            ? null
            : () {
                onSubscribe();
                Navigator.pop(context);
              },
        icon: Icon(
          advertisement.isSubscribed
              ? Icons.check_circle
              : Icons.add_shopping_cart,
        ),
        label: Text(
          advertisement.isSubscribed ? 'مشترك' : 'اشترك الآن',
          style: AppTextStyles.buttonText.copyWith(fontFamily: 'RPT'),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: advertisement.isSubscribed
              ? AppColors.success
              : AppColors.secondary,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        ),
      ),
    );
  }
}
