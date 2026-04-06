class LoginResponseData {
  final String accessToken;
  final String refreshToken;
  final UserModel? user;

  LoginResponseData({
    required this.accessToken,
    required this.refreshToken,
    this.user,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserModel {
  final String id;
  final AuthIdModel? authId;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImage;
  final String status;

  UserModel({
    required this.id,
    this.authId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImage,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      authId: json['authId'] != null && json['authId'] is Map<String, dynamic>
          ? AuthIdModel.fromJson(json['authId'] as Map<String, dynamic>)
          : null,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      profileImage: json['profile_image'] as String?,
      status: json['status'] as String,
    );
  }
}

class AuthIdModel {
  final String id;
  final String name;
  final String email;
  final String role;
  
  AuthIdModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory AuthIdModel.fromJson(Map<String, dynamic> json) {
    return AuthIdModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }
}
