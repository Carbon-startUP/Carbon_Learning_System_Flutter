// استيراد الحزمة الجديدة
import 'package:latlong2/latlong.dart';
import 'package:pasos/features/tracking/data/models/tracking_data_model.dart';
import 'package:pasos/features/tracking/data/models/tracking_status_model.dart';

class TrackingRepository {
  Future<TrackingStatusModel> getTrackingStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return TrackingStatusModel(
      braceletId: 'BR-12345',
      studentName: 'أحمد علي',
      isTrackingActive: true,
      batteryLevel: 0.85,
    );
  }

  Future<TrackingDataModel> getTrackingData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return TrackingDataModel(
      currentPosition: LatLng(24.7136, 46.6753),
      routeHistory: const [
        LatLng(24.7236, 46.6753),
        LatLng(24.7186, 46.6803),
        LatLng(24.7136, 46.6753),
      ],
    );
  }

  Future<bool> setTrackingActive(bool isActive) async {
    await Future.delayed(const Duration(seconds: 1));
    return isActive;
  }
}
