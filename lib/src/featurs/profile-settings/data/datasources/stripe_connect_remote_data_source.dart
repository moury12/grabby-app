import '../../../../src_export.dart';
import '../models/stripe_connect_model.dart';

abstract class StripeConnectRemoteDataSource {
  Future<ApiResponse<StripeConnectStatusModel>> getStripeConnectStatus();
  Future<ApiResponse<StripeOnboardingLinkModel>> getOnboardingLink({
    String? returnUrl,
    String? refreshUrl,
  });
  Future<ApiResponse<dynamic>> retryPayout(String orderId);
}

class StripeConnectRemoteDataSourceImpl implements StripeConnectRemoteDataSource {
  final ApiService _apiService;

  StripeConnectRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResponse<StripeConnectStatusModel>> getStripeConnectStatus() async {
    return await _apiService.get<StripeConnectStatusModel>(
      ApiEndpoints.stripeConnectStatus,
      fromJson: (json) {
        final data = json['data'];
        if (data != null && data is Map<String, dynamic>) {
          return StripeConnectStatusModel.fromJson(data);
        }
        return StripeConnectStatusModel(stripeAccountConnected: false);
      },
    );
  }

  @override
  Future<ApiResponse<StripeOnboardingLinkModel>> getOnboardingLink({
    String? returnUrl,
    String? refreshUrl,
  }) async {
    final Map<String, dynamic> body = {};
    if (returnUrl != null && returnUrl.isNotEmpty) {
      body['returnUrl'] = returnUrl;
    }
    if (refreshUrl != null && refreshUrl.isNotEmpty) {
      body['refreshUrl'] = refreshUrl;
    }

    return await _apiService.post<StripeOnboardingLinkModel>(
      ApiEndpoints.stripeConnectOnboardingLink,
      data: body,
      fromJson: (json) {
        final data = json['data'];
        if (data != null && data is Map<String, dynamic>) {
          return StripeOnboardingLinkModel.fromJson(data);
        }
        return StripeOnboardingLinkModel(url: '', stripeAccountConnected: false);
      },
    );
  }

  @override
  Future<ApiResponse<dynamic>> retryPayout(String orderId) async {
    return await _apiService.post(
      ApiEndpoints.retryPayout(orderId),
      fromJson: (json) => json,
    );
  }
}
