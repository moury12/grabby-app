import 'dart:io';
import '../../../../src_export.dart';
import '../models/profile_response_model.dart';
import 'package:dio/dio.dart' as dio;

abstract class ProfileRemoteDataSource {
  Future<ApiResponse<ProfileData>> getProfile();
  Future<ApiResponse<void>> updateProfile({
    required String name,
    required String addressName,
    required String lat,
    required String lon,
    File? profileImage,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService apiService;

  ProfileRemoteDataSourceImpl(this.apiService);

  @override
  Future<ApiResponse<ProfileData>> getProfile() async {
    return await apiService.get<ProfileData>(
      ApiEndpoints.profile,
      fromJson: (data) => ProfileData.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<void>> updateProfile({
    required String name,
    required String addressName,
    required String lat,
    required String lon,
    File? profileImage,
  }) async {
    final Map<String, dynamic> data = {
      "name": name,
      "addressName": addressName,
      "lat": lat,
      "lon": lon,
    };

    if (profileImage != null) {
      data["profile_image"] = await dio.MultipartFile.fromFile(
        profileImage.path,
        filename: profileImage.path.split('/').last,
      );
    }

    final formData = dio.FormData.fromMap(data);

    return await apiService.patch<void>(
      ApiEndpoints.updateProfile,
      data: formData,
    );
  }
}
