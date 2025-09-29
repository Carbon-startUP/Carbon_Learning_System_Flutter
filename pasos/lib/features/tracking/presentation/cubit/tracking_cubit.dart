import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/tracking/data/models/tracking_status_model.dart';
import 'package:pasos/features/tracking/data/repositories/tracking_repository.dart';
import 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final TrackingRepository trackingRepository;

  TrackingCubit({required this.trackingRepository}) : super(TrackingInitial());

  Future<void> fetchTrackingInfo() async {
    try {
      emit(TrackingLoading());
      final status = await trackingRepository.getTrackingStatus();
      final data = await trackingRepository.getTrackingData();
      emit(TrackingLoaded(status: status, data: data));
    } catch (e) {
      emit(const TrackingError('فشل في تحميل بيانات التتبع.'));
    }
  }

  Future<void> toggleTracking(bool currentState) async {
    final originalState = state;
    if (originalState is TrackingLoaded) {
      final newStatus = await trackingRepository.setTrackingActive(
        !currentState,
      );
      emit(
        TrackingLoaded(
          status: TrackingStatusModel(
            braceletId: originalState.status.braceletId,
            studentName: originalState.status.studentName,
            isTrackingActive: newStatus,
            batteryLevel: originalState.status.batteryLevel,
          ),
          data: originalState.data,
        ),
      );
    }
  }
}
