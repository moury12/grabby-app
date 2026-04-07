import 'dart:io';
import '../../../../src_export.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile_response_model.dart';

abstract class ProfileRepository {
  Future<ApiResponse<ProfileData>> getProfile();
  Future<ApiResponse<void>> updateProfile({
    required String name,
    required String addressName,
    required String lat,
    required String lon,
    File? profileImage,
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
    required String addressName,
    required String lat,
    required String lon,
    File? profileImage,
  }) async {
    return await remoteDataSource.updateProfile(
      name: name,
      addressName: addressName,
      lat: lat,
      lon: lon,
      profileImage: profileImage,
    );
  }
}
