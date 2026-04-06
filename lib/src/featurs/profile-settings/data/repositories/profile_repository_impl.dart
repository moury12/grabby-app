import '../../../../src_export.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile_response_model.dart';

abstract class ProfileRepository {
  Future<ApiResponse<ProfileData>> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResponse<ProfileData>> getProfile() async {
    return await remoteDataSource.getProfile();
  }
}
