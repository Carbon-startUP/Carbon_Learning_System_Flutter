import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:pasos/features/tracking/data/models/tracking_data_model.dart';

class MapWidget extends StatelessWidget {
  final TrackingDataModel trackingData;

  const MapWidget({super.key, required this.trackingData});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: trackingData.currentPosition,
        initialZoom: 14.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.pasos',
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: trackingData.routeHistory,
              strokeWidth: 5.0,
              color: Colors.blue,
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: trackingData.currentPosition,
              child: const Icon(
                Icons.location_on,
                size: 40.0,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
