import 'dart:convert';

class HealthDataModel {
  final String bloodType;
  final double height;
  final double weight;
  final List<String> allergies;
  final List<String> chronicConditions;
  final List<String> currentMedications;
  final String emergencyContact;
  final String emergencyContactPhone;
  final DateTime? lastCheckupDate;

  HealthDataModel({
    required this.bloodType,
    required this.height,
    required this.weight,
    this.allergies = const [],
    this.chronicConditions = const [],
    this.currentMedications = const [],
    required this.emergencyContact,
    required this.emergencyContactPhone,
    this.lastCheckupDate,
  });

  Map<String, dynamic> toJson() => {
    'bloodType': bloodType,
    'height': height,
    'weight': weight,
    'allergies': allergies,
    'chronicConditions': chronicConditions,
    'currentMedications': currentMedications,
    'emergencyContact': emergencyContact,
    'emergencyContactPhone': emergencyContactPhone,
    'lastCheckupDate': lastCheckupDate?.toIso8601String(),
  };

  factory HealthDataModel.fromJson(Map<String, dynamic> json) {
    return HealthDataModel(
      bloodType: json['bloodType'] ?? 'O+',
      height: (json['height'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      allergies: json['allergies'] != null
          ? List<String>.from(json['allergies'])
          : [],
      chronicConditions: json['chronicConditions'] != null
          ? List<String>.from(json['chronicConditions'])
          : [],
      currentMedications: json['currentMedications'] != null
          ? List<String>.from(json['currentMedications'])
          : [],
      emergencyContact: json['emergencyContact'] ?? '',
      emergencyContactPhone: json['emergencyContactPhone'] ?? '',
      lastCheckupDate: json['lastCheckupDate'] != null
          ? DateTime.parse(json['lastCheckupDate'])
          : null,
    );
  }

  HealthDataModel copyWith({
    String? bloodType,
    double? height,
    double? weight,
    List<String>? allergies,
    List<String>? chronicConditions,
    List<String>? currentMedications,
    String? emergencyContact,
    String? emergencyContactPhone,
    DateTime? lastCheckupDate,
  }) {
    return HealthDataModel(
      bloodType: bloodType ?? this.bloodType,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      allergies: allergies ?? this.allergies,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      currentMedications: currentMedications ?? this.currentMedications,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      lastCheckupDate: lastCheckupDate ?? this.lastCheckupDate,
    );
  }
}
