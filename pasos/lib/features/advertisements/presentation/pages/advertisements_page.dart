import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../data/repositories/advertisement_repository.dart';
import '../cubit/advertisements_cubit.dart';
import '../cubit/advertisements_state.dart';
import '../widgets/advertisement_card.dart';
import '../widgets/category_filter_widget.dart';
import '../widgets/advertisement_details_sheet.dart';

class AdvertisementsPage extends StatelessWidget {
  const AdvertisementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdvertisementsCubit(AdvertisementRepository())..loadAdvertisements(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'الإعلانات',
            style: AppTextStyles.headlineSmall.copyWith(fontFamily: 'RPT'),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<AdvertisementsCubit, AdvertisementsState>(
          builder: (context, state) {
            if (state is AdvertisementsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.secondary),
              );
            }

            if (state is AdvertisementsError) {
              return Center(
                child: Text(
                  state.message,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontFamily: 'RPT',
                    color: AppColors.error,
                  ),
                ),
              );
            }

            if (state is AdvertisementsLoaded) {
              final filteredAds = state.selectedCategory == null
                  ? state.advertisements
                  : state.advertisements
                        .where((ad) => ad.category == state.selectedCategory)
                        .toList();

              return SafeArea(
                child: Column(
                  children: [
                    CategoryFilterWidget(
                      selectedCategory: state.selectedCategory,
                      onCategorySelected: (category) {
                        context.read<AdvertisementsCubit>().filterByCategory(
                          category,
                        );
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredAds.length,
                        itemBuilder: (context, index) {
                          final ad = filteredAds[index];
                          return AdvertisementCard(
                            advertisement: ad,
                            onSubscribe: () {
                              _showSubscribeDialog(context, ad);
                            },
                            onDetails: () {
                              _showDetailsSheet(context, ad);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _showDetailsSheet(BuildContext context, advertisement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AdvertisementDetailsSheet(
        advertisement: advertisement,
        onSubscribe: () {
          context.read<AdvertisementsCubit>().subscribe(advertisement.id);
        },
      ),
    );
  }

  void _showSubscribeDialog(BuildContext context, advertisement) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.primary),
        ),
        title: Text(
          'تأكيد الاشتراك',
          style: AppTextStyles.titleMedium.copyWith(
            fontFamily: 'RPT',
            color: AppColors.secondary,
          ),
        ),
        content: Text(
          'هل تريد الاشتراك في "${advertisement.titleAr}"؟',
          style: AppTextStyles.bodyMedium.copyWith(fontFamily: 'RPT'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: AppTextStyles.labelLarge.copyWith(
                fontFamily: 'RPT',
                color: AppColors.whiteWithOpacity,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AdvertisementsCubit>().subscribe(advertisement.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تم الاشتراك بنجاح',
                    style: AppTextStyles.bodyMedium.copyWith(fontFamily: 'RPT'),
                  ),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: Text(
              'تأكيد',
              style: AppTextStyles.labelLarge.copyWith(fontFamily: 'RPT'),
            ),
          ),
        ],
      ),
    );
  }
}
