import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../data/models/advertisement_model.dart';

class AdvertisementCard extends StatelessWidget {
  final AdvertisementModel advertisement;
  final VoidCallback onSubscribe;
  final VoidCallback onDetails;

  const AdvertisementCard({
    Key? key,
    required this.advertisement,
    required this.onSubscribe,
    required this.onDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          _buildBackgroundImage(),
          _buildGradientOverlay(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: Image.network(
        advertisement.imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.primary.withOpacity(0.3),
            child: const Icon(
              Icons.image_not_supported,
              color: AppColors.white,
              size: 50,
            ),
          );
        },
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, AppColors.background.withOpacity(0.9)],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            advertisement.titleAr,
            style: AppTextStyles.titleMedium.copyWith(
              fontFamily: 'RPT',
              color: AppColors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.whiteWithOpacity,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Expanded(
                child: Text(
                  advertisement.locationAr,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontFamily: 'RPT',
                    color: AppColors.whiteWithOpacity,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${advertisement.price} ${advertisement.priceUnit}',
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.secondary,
                ),
              ),
              Row(
                children: [
                  _buildActionButton(
                    icon: Icons.info_outline,
                    onTap: onDetails,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  _buildActionButton(
                    icon: advertisement.isSubscribed
                        ? Icons.check_circle
                        : Icons.add_shopping_cart,
                    onTap: advertisement.isSubscribed ? null : onSubscribe,
                    color: advertisement.isSubscribed
                        ? AppColors.success
                        : AppColors.secondary,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback? onTap,
    Color? color,
  }) {
    return Material(
      color: AppColors.whiteWithOpacity.withOpacity(0.2),
      borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Icon(icon, color: color ?? AppColors.white, size: 24),
        ),
      ),
    );
  }
}
