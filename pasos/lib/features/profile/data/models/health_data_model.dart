class HealthDataModel {
  final String bloodType;

  final List<String> chronicConditions;
  final List<String> currentMedications;

  HealthDataModel({
    required this.bloodType,

    this.chronicConditions = const [],
    this.currentMedications = const [],
  });

  Map<String, dynamic> toJson() => {
    'bloodType': bloodType,

    'chronicConditions': chronicConditions,
    'currentMedications': currentMedications,
  };

  factory HealthDataModel.fromJson(Map<String, dynamic> json) {
    return HealthDataModel(
      bloodType: json['bloodType'] ?? 'O+',
      chronicConditions: json['chronicConditions'] != null
          ? List<String>.from(json['chronicConditions'])
          : [],
      currentMedications: json['currentMedications'] != null
          ? List<String>.from(json['currentMedications'])
          : [],
    );
  }

  HealthDataModel copyWith({
    String? bloodType,

    List<String>? allergies,
    List<String>? chronicConditions,
    List<String>? currentMedications,
    String? emergencyContact,
    String? emergencyContactPhone,
    DateTime? lastCheckupDate,
  }) {
    return HealthDataModel(
      bloodType: bloodType ?? this.bloodType,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      currentMedications: currentMedications ?? this.currentMedications,
    );
  }
}
