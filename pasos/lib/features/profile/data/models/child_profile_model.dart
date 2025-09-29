import 'dart:convert';
import 'package:pasos/features/profile/data/models/health_data_model.dart';

class ChildProfileModel {
  final String id;
  final int cardId;
  final int braceletId;
  final String religion;
  final String nationality;
  final String email;
  final int age;
  final int phoneNumber;
  final String parentId;
  final String fullName;
  final DateTime dateOfBirth;
  final String gender;
  final HealthDataModel healthData;

  ChildProfileModel({
    required this.id,
    required this.cardId,
    required this.braceletId,
    required this.religion,
    required this.nationality,
    required this.email,
    required this.age,
    required this.phoneNumber,
    required this.parentId,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.healthData,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'parentId': parentId,
    'fullName': fullName,
    'cardId': cardId,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'gender': gender,
    'religion': religion,
    'nationality': nationality,
    'braceletId': braceletId,
    'email': email,
    'age': age,
    'phoneNumber': phoneNumber,
    'healthData': jsonEncode(healthData.toJson()),
  };

  factory ChildProfileModel.fromJson(Map<String, dynamic> json) =>
      ChildProfileModel(
        id: json['id'],
        parentId: json['parentId'],
        fullName: json['fullName'],
        cardId: json['cardId'],
        dateOfBirth: DateTime.parse(json['dateOfBirth']),
        gender: json['gender'],
        religion: json['religion'],
        nationality: json['nationality'],
        email: json['email'],
        age: json['age'],
        phoneNumber: json['phoneNumber'],
        braceletId: json['braceletId'],
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
    int? cardId,
    DateTime? dateOfBirth,
    String? gender,
    int? braceletId,
    String? religion,
    String? nationality,
    String? email,
    int? age,
    int? phoneNumber,

    HealthDataModel? healthData,
  }) {
    return ChildProfileModel(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      fullName: fullName ?? this.fullName,
      cardId: cardId ?? this.cardId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      healthData: healthData ?? this.healthData,
      braceletId: braceletId ?? this.braceletId,
      religion: religion ?? this.religion,
      nationality: nationality ?? this.nationality,
      email: email ?? this.email,
      age: age ?? this.age,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
