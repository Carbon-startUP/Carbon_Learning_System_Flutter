import 'package:equatable/equatable.dart';

class ScheduleModel extends Equatable {
  final String id;
  final String dayName;
  final int dayIndex;
  final List<ClassModel> classes;

  const ScheduleModel({
    required this.id,
    required this.dayName,
    required this.dayIndex,
    required this.classes,
  });

  @override
  List<Object?> get props => [id, dayName, dayIndex, classes];
}

class ClassModel extends Equatable {
  final String id;
  final String subjectName;
  final String teacherName;
  final String teacherId;
  final String startTime;
  final String endTime;
  final String roomNumber;
  final int periodNumber;

  const ClassModel({
    required this.id,
    required this.subjectName,
    required this.teacherName,
    required this.teacherId,
    required this.startTime,
    required this.endTime,
    required this.roomNumber,
    required this.periodNumber,
  });

  @override
  List<Object?> get props => [
    id,
    subjectName,
    teacherName,
    teacherId,
    startTime,
    endTime,
    roomNumber,
    periodNumber,
  ];
}
