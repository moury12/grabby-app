import '../../../../../src_export.dart';
import '../models/terms_and_conditions_model.dart';
import '../models/help_center_model.dart';

abstract class SupportRemoteDataSource {
  Future<ApiResponse<List<TermsAndConditionsModel>>> getTermsAndConditions();
  Future<ApiResponse<List<HelpCenterModel>>> getHelpCenter();
}

class SupportRemoteDataSourceImpl implements SupportRemoteDataSource {
  final ApiService _apiService;

  SupportRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResponse<List<TermsAndConditionsModel>>> getTermsAndConditions() async {
    final response = await _apiService.get(ApiEndpoints.termsAndConditions);
    return ApiResponse.fromJson(
      response.data,
      (json) => (json as List)
          .map((e) => TermsAndConditionsModel.fromJson(e))
          .toList(),
    );
  }

  @override
  Future<ApiResponse<List<HelpCenterModel>>> getHelpCenter() async {
    final response = await _apiService.get(ApiEndpoints.helpCenter);
    return ApiResponse.fromJson(
      response.data,
      (json) => (json as List).map((e) => HelpCenterModel.fromJson(e)).toList(),
    );
  }
}
