class AdvertisementModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final String imageUrl;
  final double price;
  final String priceUnit;
  final String category;
  final String locationAr;
  final String locationEn;
  final bool isSubscribed;

  AdvertisementModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.imageUrl,
    required this.price,
    required this.priceUnit,
    required this.category,
    required this.locationAr,
    required this.locationEn,
    this.isSubscribed = false,
  });

  AdvertisementModel copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? descriptionAr,
    String? descriptionEn,
    String? imageUrl,
    double? price,
    String? priceUnit,
    String? category,
    String? locationAr,
    String? locationEn,
    bool? isSubscribed,
  }) {
    return AdvertisementModel(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      priceUnit: priceUnit ?? this.priceUnit,
      category: category ?? this.category,
      locationAr: locationAr ?? this.locationAr,
      locationEn: locationEn ?? this.locationEn,
      isSubscribed: isSubscribed ?? this.isSubscribed,
    );
  }
}
