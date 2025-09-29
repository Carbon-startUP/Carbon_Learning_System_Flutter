import 'package:equatable/equatable.dart';
import 'package:pasos/features/tracking/data/models/tracking_data_model.dart';
import 'package:pasos/features/tracking/data/models/tracking_status_model.dart';

abstract class TrackingState extends Equatable {
  const TrackingState();
  @override
  List<Object?> get props => [];
}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class TrackingLoaded extends TrackingState {
  final TrackingStatusModel status;
  final TrackingDataModel data;

  const TrackingLoaded({required this.status, required this.data});

  @override
  List<Object?> get props => [status, data];
}

class TrackingError extends TrackingState {
  final String message;
  const TrackingError(this.message);
  @override
  List<Object?> get props => [message];
}
