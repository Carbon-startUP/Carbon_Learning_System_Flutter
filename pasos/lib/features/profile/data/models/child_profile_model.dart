import 'dart:convert';
import 'package:pasos/features/profile/data/models/health_data_model.dart';

class ChildProfileModel {
  final String id;
  final String parentId;
  final String fullName;
  final DateTime dateOfBirth;
  final String gender;
  final String? schoolName;
  final String? grade;
  final HealthDataModel healthData;

  ChildProfileModel({
    required this.id,
    required this.parentId,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    this.schoolName,
    this.grade,
    required this.healthData,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'parentId': parentId,
    'fullName': fullName,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'gender': gender,
    'schoolName': schoolName,
    'grade': grade,
    'healthData': jsonEncode(
      healthData.toJson(),
    ), // Convert to JSON string for SQLite
  };

  factory ChildProfileModel.fromJson(Map<String, dynamic> json) =>
      ChildProfileModel(
        id: json['id'],
        parentId: json['parentId'],
        fullName: json['fullName'],
        dateOfBirth: DateTime.parse(json['dateOfBirth']),
        gender: json['gender'],
        schoolName: json['schoolName'],
        grade: json['grade'],
        healthData: HealthDataModel.fromJson(
          json['healthData'] is String
              ? jsonDecode(json['healthData'])
              : json['healthData'],
        ),
      );

  ChildProfileModel copyWith({
    String? id,
    String? parentId,
    String? fullName,
    DateTime? dateOfBirth,
    String? gender,
    String? schoolName,
    String? grade,
    HealthDataModel? healthData,
  }) {
    return ChildProfileModel(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      schoolName: schoolName ?? this.schoolName,
      grade: grade ?? this.grade,
      healthData: healthData ?? this.healthData,
    );
  }
}
