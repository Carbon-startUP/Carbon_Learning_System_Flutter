import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/schedule/data/repositories/schedule_repository.dart';
import 'package:pasos/features/schedule/presentation/cubit/schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepository _repository;

  ScheduleCubit(this._repository) : super(ScheduleInitial());

  Future<void> loadWeeklySchedule() async {
    emit(ScheduleLoading());
    try {
      final schedule = await _repository.getWeeklySchedule();
      emit(ScheduleLoaded(schedule: schedule));
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  Future<void> loadTeachers() async {
    emit(TeachersLoading());
    try {
      final teachers = await _repository.getTeachers();
      emit(TeachersLoaded(teachers: teachers));
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  Future<void> loadMeetings() async {
    emit(MeetingsLoading());
    try {
      final meetings = await _repository.getMeetings();
      emit(MeetingsLoaded(meetings: meetings));
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  Future<void> requestMeeting(Map<String, dynamic> meetingData) async {
    emit(MeetingRequestLoading());
    try {
      final success = await _repository.requestMeeting(meetingData);
      if (success) {
        emit(MeetingRequestSuccess());
      } else {
        emit(const MeetingRequestError(message: 'فشل في إرسال الطلب'));
      }
    } catch (e) {
      emit(MeetingRequestError(message: e.toString()));
    }
  }
}
