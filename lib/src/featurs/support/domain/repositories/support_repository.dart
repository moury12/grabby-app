import '../../../../src_export.dart';
import '../data/datasources/support_remote_data_source.dart';
import '../data/models/terms_and_conditions_model.dart';
import '../data/models/help_center_model.dart';

abstract class SupportRepository {
  Future<ApiResponse<List<TermsAndConditionsModel>>> getTermsAndConditions();
  Future<ApiResponse<List<HelpCenterModel>>> getHelpCenter();
}

class SupportRepositoryImpl implements SupportRepository {
  final SupportRemoteDataSource _remoteDataSource;

  SupportRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResponse<List<TermsAndConditionsModel>>> getTermsAndConditions() {
    return _remoteDataSource.getTermsAndConditions();
  }

  @override
  Future<ApiResponse<List<HelpCenterModel>>> getHelpCenter() {
    return _remoteDataSource.getHelpCenter();
  }
}
