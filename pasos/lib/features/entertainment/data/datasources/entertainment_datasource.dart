import '../models/entertainment_category_model.dart';

class EntertainmentDatasource {
  static List<EntertainmentCategoryModel> getCategories() {
    return [
      EntertainmentCategoryModel(
        id: '1',
        title: 'كرتون غارنش',
        backgroundImage: 'assets/images/garnesh.jpg',
        videos: [
          VideoModel(
            id: '1',
            title: 'الحلقة الاولي من غارنش',
            thumbnailImage: 'assets/images/garnesh.jpg',
            videoUrl:
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
          ),
          VideoModel(
            id: '2',
            title: 'الحلقة الثانية من غارنش',
            thumbnailImage: 'assets/images/garnesh.jpg',
            videoUrl:
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
          ),
          VideoModel(
            id: '3',
            title: 'الحلقة الثالثة من غارنش',
            thumbnailImage: 'assets/images/garnesh.jpg',
            videoUrl:
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
          ),
        ],
      ),
    ];
  }
}
