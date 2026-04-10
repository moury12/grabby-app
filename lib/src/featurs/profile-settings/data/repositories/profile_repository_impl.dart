import 'dart:io';
import '../../../../src_export.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile_response_model.dart';

abstract class ProfileRepository {
  Future<ApiResponse<ProfileData>> getProfile();
  Future<ApiResponse<void>> updateProfile({
    required String name,
    File? profileImage,
    String? email,
    String? phoneNumber,
    String? shopName,
    String? shopLicenseNumber,
    String? contactEmail,
    String? contactPhone,
  });
  Future<ApiResponse<void>> updateUserLocation({
    required String addressName,
    required double lat,
    required double lon,
  });
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResponse<ProfileData>> getProfile() async {
    return await remoteDataSource.getProfile();
  }

  @override
  Future<ApiResponse<void>> updateProfile({
    required String name,
    File? profileImage,
    String? email,
    String? phoneNumber,
    String? shopName,
    String? shopLicenseNumber,
    String? contactEmail,
    String? contactPhone,
  }) async {
    return await remoteDataSource.updateProfile(
      name: name,
      profileImage: profileImage,
      email: email,
      phoneNumber: phoneNumber,
      shopName: shopName,
      shopLicenseNumber: shopLicenseNumber,
      contactEmail: contactEmail,
      contactPhone: contactPhone,
    );
  }

  @override
  Future<ApiResponse<void>> updateUserLocation({
    required String addressName,
    required double lat,
    required double lon,
  }) async {
    return await remoteDataSource.updateUserLocation(
      addressName: addressName,
      lat: lat,
      lon: lon,
    );
  }
}
