import 'package:equatable/equatable.dart';

class TeacherModel extends Equatable {
  final String id;
  final String name;
  final String subject;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final List<String> availableTimeSlots;

  const TeacherModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.availableTimeSlots,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    subject,
    email,
    phoneNumber,
    profileImage,
    availableTimeSlots,
  ];
}
