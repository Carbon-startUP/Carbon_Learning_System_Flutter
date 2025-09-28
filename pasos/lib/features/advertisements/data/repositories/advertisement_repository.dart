import '../models/advertisement_model.dart';

class AdvertisementRepository {
  List<AdvertisementModel> get _advertisements => [
    AdvertisementModel(
      id: '1',
      titleAr: 'مساحة عمل مشتركة - القاهرة',
      titleEn: 'Co-working Space - Riyadh',
      descriptionAr: 'مساحة عمل حديثة مع جميع المرافق',
      descriptionEn: 'Modern workspace with all facilities',
      imageUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c',
      price: 1500,
      priceUnit: 'جنيه/شهر',
      category: 'مساحات عمل',
      locationAr: 'القاهرة - حي فؤاد',
      locationEn: 'Cairo - Fouad District',
    ),
    AdvertisementModel(
      id: '2',
      titleAr: 'نادي رياضي متكامل',
      titleEn: 'Complete Sports Club',
      descriptionAr: 'نادي رياضي بأحدث الأجهزة والمعدات',
      descriptionEn: 'Sports club with latest equipment',
      imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48',
      price: 300,
      priceUnit: 'جنيه/شهر',
      category: 'أماكن ترفيهية',
      locationAr: 'القاهرة - الكورنيش',
      locationEn: 'Cairo - Corniche',
    ),
    AdvertisementModel(
      id: '3',
      titleAr: 'دورة تطوير البرمجيات',
      titleEn: 'Software Development Course',
      descriptionAr: 'دورة شاملة في تطوير التطبيقات',
      descriptionEn: 'Comprehensive app development course',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1661877737564-3dfd7282efcb?q=80&w=1200&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      price: 2500,
      priceUnit: 'جنيه/دورة',
      category: 'دورات تدريبية',
      locationAr: 'القاهرة - شيخ زايد',
      locationEn: 'Cairo - Sheikh Zayed',
      isSubscribed: true,
    ),
    AdvertisementModel(
      id: '4',
      titleAr: 'مقهى ومساحة عمل',
      titleEn: 'Cafe & Workspace',
      descriptionAr: 'مقهى هادئ مع مساحة للعمل',
      descriptionEn: 'Quiet cafe with workspace',
      imageUrl: 'https://images.unsplash.com/photo-1521017432531-fbd92d768814',
      price: 50,
      priceUnit: 'جنيه/يوم',
      category: 'مساحات عمل',
      locationAr: 'القاهرة - مصر الجديدة',
      locationEn: 'Cairo - New Cairo',
    ),
  ];
  final Set<String> _subscribedIds = {'3'};

  Future<List<AdvertisementModel>> getAdvertisements() async {
    await Future.delayed(const Duration(seconds: 1));
    return _advertisements
        .map(
          (ad) => AdvertisementModel(
            id: ad.id,
            titleAr: ad.titleAr,
            titleEn: ad.titleEn,
            descriptionAr: ad.descriptionAr,
            descriptionEn: ad.descriptionEn,
            imageUrl: ad.imageUrl,
            price: ad.price,
            priceUnit: ad.priceUnit,
            category: ad.category,
            locationAr: ad.locationAr,
            locationEn: ad.locationEn,
            isSubscribed: _subscribedIds.contains(ad.id),
          ),
        )
        .toList();
  }

  Future<void> subscribe(String advertisementId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _subscribedIds.add(advertisementId);
  }

  Future<void> unsubscribe(String advertisementId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _subscribedIds.remove(advertisementId);
  }
}
