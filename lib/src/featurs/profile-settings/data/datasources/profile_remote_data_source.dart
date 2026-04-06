import '../../../../src_export.dart';
import '../models/profile_response_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponseModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService apiService;

  ProfileRemoteDataSourceImpl(this.apiService);

  @override
  Future<ProfileResponseModel> getProfile() async {
    final response = await apiService.get(ApiEndpoints.profile);
    return ProfileResponseModel.fromJson(response.data);
  }
}
