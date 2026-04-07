import '../../../../src_export.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResponse<void>> registerCustomer({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required bool termsAccepted,
  }) async {
    return await _remoteDataSource.registerCustomer(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
      termsAccepted: termsAccepted,
    );
  }

  @override
  Future<ApiResponse<LoginResponseData>> login({
    required String email,
    required String password,
  }) async {
    return await _remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<ApiResponse<void>> verifyOtp({
    required String email,
    required String activationCode,
  }) async {
    return await _remoteDataSource.verifyOtp(
      email: email,
      activationCode: activationCode,
    );
  }

  @override
  Future<ApiResponse<void>> resendOtp({required String email}) async {
    return await _remoteDataSource.resendOtp(email: email);
  }

  @override
  Future<ApiResponse<void>> forgotPassword({required String email}) async {
    return await _remoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<ApiResponse<void>> resendForgotCode({required String email}) async {
    return await _remoteDataSource.resendForgotCode(email: email);
  }

  @override
  Future<ApiResponse<void>> verifyForgotOtp({
    required String email,
    required String activationCode,
  }) async {
    return await _remoteDataSource.verifyForgotOtp(
      email: email,
      activationCode: activationCode,
    );
  }

  @override
  Future<ApiResponse<void>> changePassword({
    String? oldPassword,
    String? email,
    String? code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await _remoteDataSource.changePassword(
      oldPassword: oldPassword,
      email: email,
      code: code,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
