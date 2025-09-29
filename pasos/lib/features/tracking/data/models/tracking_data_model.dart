import 'package:latlong2/latlong.dart';

class TrackingDataModel {
  final LatLng currentPosition;
  final List<LatLng> routeHistory;

  TrackingDataModel({
    required this.currentPosition,
    required this.routeHistory,
  });
}
