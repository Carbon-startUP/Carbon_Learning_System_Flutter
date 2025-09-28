class EntertainmentCategoryModel {
  final String id;
  final String title;
  final String backgroundImage;
  final List<VideoModel> videos;

  EntertainmentCategoryModel({
    required this.id,
    required this.title,
    required this.backgroundImage,
    required this.videos,
  });
}

class VideoModel {
  final String id;
  final String title;
  final String thumbnailImage;
  final String videoUrl;

  VideoModel({
    required this.id,
    required this.title,
    required this.thumbnailImage,
    required this.videoUrl,
  });
}
