import 'dart:io';
import '../../../../src_export.dart';
import '../models/profile_response_model.dart';
import 'package:dio/dio.dart' as dio;

abstract class ProfileRemoteDataSource {
  Future<ApiResponse<ProfileData>> getProfile();
  Future<ApiResponse<void>> updateProfile({
    required String name,
    File? profileImage,
  });
  Future<ApiResponse<void>> updateUserLocation({
    required String addressName,
    required double lat,
    required double lon,
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
    File? profileImage,
  }) async {
    final Map<String, dynamic> data = {
      "name": name,
    };

    if (profileImage != null) {
      data["profile_image"] = await dio.MultipartFile.fromFile(
        profileImage.path,
        filename: profileImage.path.split('/').last,
      );
      
      final formData = dio.FormData.fromMap(data);
      return await apiService.patch<void>(
        ApiEndpoints.updateProfile,
        data: formData,
      );
    }

    return await apiService.patch<void>(
      ApiEndpoints.updateProfile,
      data: data,
    );
  }

  @override
  Future<ApiResponse<void>> updateUserLocation({
    required String addressName,
    required double lat,
    required double lon,
  }) async {
    final Map<String, dynamic> data = {
      "addressName": addressName,
      "lat": lat,
      "lon": lon,
    };

    return await apiService.patch<void>(
      ApiEndpoints.updateUserLocation,
      data: data,
    );
  }
}
