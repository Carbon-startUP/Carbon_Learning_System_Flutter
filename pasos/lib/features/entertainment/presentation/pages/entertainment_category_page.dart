import 'package:flutter/material.dart';
import 'package:pasos/core/navigation/app_router.dart';
import 'package:pasos/features/entertainment/data/models/entertainment_category_model.dart';
import 'package:pasos/features/entertainment/presentation/widgets/video_card.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';
import 'package:pasos/shared/theme/app_spacing.dart';

class EntertainmentCategoryPage extends StatelessWidget {
  final String categoryTitle;
  final List<VideoModel> videos;

  const EntertainmentCategoryPage({
    super.key,
    required this.categoryTitle,
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
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
                  'اختر الفيديو الذي تريد مشاهدته',
                  style: AppTextStyles.arabicBody.copyWith(fontSize: 18),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: AppSpacing.lg),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      return VideoCard(
                        title: video.title,
                        thumbnailImage: video.thumbnailImage,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.videoPlayer,
                            arguments: {
                              'videoUrl': video.videoUrl,
                              'videoTitle': video.title,
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
