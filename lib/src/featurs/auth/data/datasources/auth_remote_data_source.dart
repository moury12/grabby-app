import '../../../../src_export.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse<void>> registerCustomer({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required bool termsAccepted,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResponse<void>> registerCustomer({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required bool termsAccepted,
  }) async {
    return await _apiService.post<void>(
      ApiEndpoints.customerRegister,
      data: {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
        "termsAccepted": termsAccepted,
      },
    );
  }
}
