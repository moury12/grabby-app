class ProfileResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final ProfileData? data;

  ProfileResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.data,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }
}

class ProfileData {
  final String id;
  final AuthId authId;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImage;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileData({
    required this.id,
    required this.authId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImage,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['_id'],
      authId: AuthId.fromJson(json['authId']),
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      profileImage: json['profile_image'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class AuthId {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String role;
  final String? profileImage;
  final bool termsAccepted;
  final String? activationCode;
  final String? expirationTime;
  final bool codeVerify;
  final bool isBlock;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  AuthId({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.profileImage,
    required this.termsAccepted,
    this.activationCode,
    this.expirationTime,
    required this.codeVerify,
    required this.isBlock,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuthId.fromJson(Map<String, dynamic> json) {
    return AuthId(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      role: json['role'],
      profileImage: json['profile_image'],
      termsAccepted: json['termsAccepted'] ?? false,
      activationCode: json['activationCode'],
      expirationTime: json['expirationTime'],
      codeVerify: json['codeVerify'] ?? false,
      isBlock: json['is_block'] ?? false,
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
