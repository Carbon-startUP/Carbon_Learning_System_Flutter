import 'package:equatable/equatable.dart';

class CurriculumModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String subject;
  final String grade;
  final String fileUrl;
  final String fileType;

  const CurriculumModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.grade,
    required this.fileUrl,
    required this.fileType,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    subject,
    grade,
    fileUrl,
    fileType,
  ];

  factory CurriculumModel.fromJson(Map<String, dynamic> json) {
    return CurriculumModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      subject: json['subject'],
      grade: json['grade'],
      fileUrl: json['fileUrl'],
      fileType: json['fileType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subject': subject,
      'grade': grade,
      'fileUrl': fileUrl,
      'fileType': fileType,
    };
  }
}
