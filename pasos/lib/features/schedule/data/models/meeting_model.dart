import 'package:equatable/equatable.dart';

class MeetingModel extends Equatable {
  final String id;
  final String teacherId;
  final String teacherName;
  final String studentId;
  final String studentName;
  final DateTime requestDate;
  final DateTime meetingDate;
  final String timeSlot;
  final String subject;
  final String description;
  final MeetingStatus status;

  const MeetingModel({
    required this.id,
    required this.teacherId,
    required this.teacherName,
    required this.studentId,
    required this.studentName,
    required this.requestDate,
    required this.meetingDate,
    required this.timeSlot,
    required this.subject,
    required this.description,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    teacherId,
    teacherName,
    studentId,
    studentName,
    requestDate,
    meetingDate,
    timeSlot,
    subject,
    description,
    status,
  ];
}

enum MeetingStatus { pending, approved, rejected, completed }
