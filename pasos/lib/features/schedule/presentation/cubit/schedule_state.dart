import 'package:equatable/equatable.dart';
import 'package:pasos/features/schedule/data/models/schedule_model.dart';
import 'package:pasos/features/schedule/data/models/teacher_model.dart';
import 'package:pasos/features/schedule/data/models/meeting_model.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<ScheduleModel> schedule;

  const ScheduleLoaded({required this.schedule});

  @override
  List<Object?> get props => [schedule];
}

class TeachersLoading extends ScheduleState {}

class TeachersLoaded extends ScheduleState {
  final List<TeacherModel> teachers;

  const TeachersLoaded({required this.teachers});

  @override
  List<Object?> get props => [teachers];
}

class MeetingsLoading extends ScheduleState {}

class MeetingsLoaded extends ScheduleState {
  final List<MeetingModel> meetings;

  const MeetingsLoaded({required this.meetings});

  @override
  List<Object?> get props => [meetings];
}

class MeetingRequestLoading extends ScheduleState {}

class MeetingRequestSuccess extends ScheduleState {}

class MeetingRequestError extends ScheduleState {
  final String message;

  const MeetingRequestError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError({required this.message});

  @override
  List<Object?> get props => [message];
}
