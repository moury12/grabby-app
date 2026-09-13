import '../../../../src_export.dart';
import '../models/stripe_connect_model.dart';
import '../datasources/stripe_connect_remote_data_source.dart';

abstract class StripeConnectRepository {
  Future<ApiResponse<StripeConnectStatusModel>> getStripeConnectStatus();
  Future<ApiResponse<StripeOnboardingLinkModel>> getOnboardingLink({
    String? returnUrl,
    String? refreshUrl,
  });
  Future<ApiResponse<dynamic>> retryPayout(String orderId);
}

class StripeConnectRepositoryImpl implements StripeConnectRepository {
  final StripeConnectRemoteDataSource _remoteDataSource;

  StripeConnectRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResponse<StripeConnectStatusModel>> getStripeConnectStatus() async {
    try {
      return await _remoteDataSource.getStripeConnectStatus();
    } on ApiException catch (e) {
      return ApiResponse(
        statusCode: e.statusCode ?? 500,
        success: false,
        message: e.message,
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 500,
        success: false,
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<ApiResponse<StripeOnboardingLinkModel>> getOnboardingLink({
    String? returnUrl,
    String? refreshUrl,
  }) async {
    try {
      return await _remoteDataSource.getOnboardingLink(
        returnUrl: returnUrl,
        refreshUrl: refreshUrl,
      );
    } on ApiException catch (e) {
      return ApiResponse(
        statusCode: e.statusCode ?? 500,
        success: false,
        message: e.message,
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 500,
        success: false,
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<ApiResponse<dynamic>> retryPayout(String orderId) async {
    try {
      return await _remoteDataSource.retryPayout(orderId);
    } on ApiException catch (e) {
      return ApiResponse(
        statusCode: e.statusCode ?? 500,
        success: false,
        message: e.message,
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 500,
        success: false,
        message: 'Unexpected error: $e',
      );
    }
  }
}
