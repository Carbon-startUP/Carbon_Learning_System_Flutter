class UserModel {
  final String id;
  final String username;
  final String fullName;
  final String userType;
  final String sessionToken;

  UserModel({
    required this.id,
    required this.username,
    required this.fullName,
    required this.userType,
    required this.sessionToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['data']['user']['id'],
      username: json['data']['user']['username'],
      fullName: json['data']['user']['fullName'],
      userType: json['data']['user']['userType'],
      sessionToken: json['data']['sessionToken'],
    );
  }
}
