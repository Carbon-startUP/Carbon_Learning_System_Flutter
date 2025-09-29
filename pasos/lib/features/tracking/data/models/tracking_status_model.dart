class TrackingStatusModel {
  final String braceletId;
  final String studentName;
  final bool isTrackingActive;
  final double batteryLevel;

  TrackingStatusModel({
    required this.braceletId,
    required this.studentName,
    required this.isTrackingActive,
    required this.batteryLevel,
  });
}
