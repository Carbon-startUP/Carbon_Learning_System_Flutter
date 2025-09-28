import 'dart:convert';

class UserProfileModel {
  final String id;
  final String cardIdNumber;
  final String fullName;
  final DateTime dateOfBirth;
  final String gender;
  final String phoneNumber;
  final String email;
  final String address;
  final DateTime? lastUpdated;
  final List<String> childrenIds;

  UserProfileModel({
    required this.id,
    required this.cardIdNumber,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.address,
    this.lastUpdated,
    this.childrenIds = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'cardIdNumber': cardIdNumber,
    'fullName': fullName,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'gender': gender,
    'phoneNumber': phoneNumber,
    'email': email,
    'address': address,
    'lastUpdated': lastUpdated?.toIso8601String(),
    'childrenIds': childrenIds.join(
      ',',
    ), // Convert list to comma-separated string
  };

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json['id'],
        cardIdNumber: json['cardIdNumber'],
        fullName: json['fullName'],
        dateOfBirth: DateTime.parse(json['dateOfBirth']),
        gender: json['gender'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        address: json['address'],
        lastUpdated: json['lastUpdated'] != null
            ? DateTime.parse(json['lastUpdated'])
            : null,
        childrenIds:
            json['childrenIds'] != null &&
                json['childrenIds'].toString().isNotEmpty
            ? json['childrenIds'].toString().split(',')
            : [],
      );

  UserProfileModel copyWith({
    String? id,
    String? cardIdNumber,
    String? fullName,
    DateTime? dateOfBirth,
    String? gender,
    String? phoneNumber,
    String? email,
    String? address,
    DateTime? lastUpdated,
    List<String>? childrenIds,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      cardIdNumber: cardIdNumber ?? this.cardIdNumber,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      childrenIds: childrenIds ?? this.childrenIds,
    );
  }
}
