import '../datasources/profile_remote_data_source.dart';
import '../models/profile_response_model.dart';

abstract class ProfileRepository {
  Future<ProfileResponseModel> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProfileResponseModel> getProfile() async {
    return await remoteDataSource.getProfile();
  }
}
