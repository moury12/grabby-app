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

  Future<ApiResponse<LoginResponseData>> login({
    required String email,
    required String password,
  });

  Future<ApiResponse<void>> verifyOtp({
    required String email,
    required String activationCode,
  });

  Future<ApiResponse<void>> resendOtp({
    required String email,
  });

  Future<ApiResponse<void>> forgotPassword({
    required String email,
  });

  Future<ApiResponse<void>> resendForgotCode({
    required String email,
  });

  Future<ApiResponse<void>> verifyForgotOtp({
    required String email,
    required String activationCode,
  });

  Future<ApiResponse<void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
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

  @override
  Future<ApiResponse<LoginResponseData>> login({
    required String email,
    required String password,
  }) async {
    return await _apiService.post<LoginResponseData>(
      ApiEndpoints.customerLogin,
      data: {
        "email": email,
        "password": password,
      },
      fromJson: (data) => LoginResponseData.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<void>> verifyOtp({
    required String email,
    required String activationCode,
  }) async {
    return await _apiService.post<void>(
      ApiEndpoints.verifyOtp,
      data: {
        "email": email,
        "activation_code": activationCode,
      },
    );
  }

  @override
  Future<ApiResponse<void>> resendOtp({
    required String email,
  }) async {
    return await _apiService.post<void>(
      ApiEndpoints.resendOtp,
      data: {
        "email": email,
      },
    );
  }

  @override
  Future<ApiResponse<void>> forgotPassword({
    required String email,
  }) async {
    return await _apiService.post<void>(
      ApiEndpoints.forgotPassword,
      data: {
        "email": email,
      },
    );
  }

  @override
  Future<ApiResponse<void>> resendForgotCode({
    required String email,
  }) async {
    return await _apiService.post<void>(
      ApiEndpoints.resendForgotCode,
      data: {
        "email": email,
      },
    );
  }

  @override
  Future<ApiResponse<void>> verifyForgotOtp({
    required String email,
    required String activationCode,
  }) async {
    return await _apiService.post<void>(
      ApiEndpoints.verifyForgotOtp,
      data: {
        "email": email,
        "activation_code": activationCode,
      },
    );
  }

  @override
  Future<ApiResponse<void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await _apiService.patch<void>(
      ApiEndpoints.changePassword,
      data: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      },
    );
  }
}
