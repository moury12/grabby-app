import 'dart:io';
import '../../../../src_export.dart';
import '../models/profile_response_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:jwt_decoder/jwt_decoder.dart';

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
  final LocalStorageService localStorageService;

  ProfileRemoteDataSourceImpl(this.apiService, this.localStorageService);

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

    String endpoint = ApiEndpoints.updateUserLocation;

    final token = localStorageService.getAccessToken();
    if (token != null && !JwtDecoder.isExpired(token)) {
      final decodedToken = JwtDecoder.decode(token);
      final role = decodedToken['role'] as String?;
      if (role == 'SHOP_OWNER') {
        endpoint = ApiEndpoints.updateShopOwnerLocation;
      }
    }

    return await apiService.patch<void>(
      endpoint,
      data: data,
    );
  }
}
