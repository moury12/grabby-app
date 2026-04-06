import '../../../../src_export.dart';
import '../models/profile_response_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ApiResponse<ProfileData>> getProfile();
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
}
