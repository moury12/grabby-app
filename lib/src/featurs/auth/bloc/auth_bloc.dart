import '../../../src_export.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<RegisterCustomerEvent>(_onRegisterCustomer);
    on<LoginEvent>(_onLogin);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResendOtpEvent>(_onResendOtp);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResendForgotCodeEvent>(_onResendForgotCode);
    on<VerifyForgotOtpEvent>(_onVerifyForgotOtp);
    on<ChangePasswordEvent>(_onChangePassword);
  }

  Future<void> _onRegisterCustomer(
    RegisterCustomerEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.registerCustomer(
        name: event.name,
        email: event.email,
        phoneNumber: event.phoneNumber,
        password: event.password,
        confirmPassword: event.confirmPassword,
        termsAccepted: event.termsAccepted,
      );

      if (response.success) {
        emit(RegisterSuccess(message: response.message));
      } else {
        emit(AuthFailure(message: response.message));
      }
    } on ApiException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.login(
        email: event.email,
        password: event.password,
      );

      if (response.success && response.data != null) {
        emit(LoginSuccess(loginData: response.data!, message: response.message));
      } else {
        emit(AuthFailure(message: response.message));
      }
    } on ApiException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.verifyOtp(
        email: event.email,
        activationCode: event.activationCode,
      );

      if (response.success) {
        emit(VerifyOtpSuccess(message: response.message));
      } else {
        emit(AuthFailure(message: response.message));
      }
    } on ApiException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> _onResendOtp(
    ResendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.resendOtp(email: event.email);

      if (response.success) {
        emit(OtpSentSuccess(message: response.message));
      } else {
        emit(AuthFailure(message: response.message));
      }
    } on ApiException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.forgotPassword(email: event.email);

      if (response.success) {
        emit(ForgotPasswordSuccess(message: response.message));
      } else {
        emit(AuthFailure(message: response.message));
      }
    } on ApiException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> _onResendForgotCode(
    ResendForgotCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.resendForgotCode(email: event.email);

      if (response.success) {
        emit(OtpSentSuccess(message: response.message));
      } else {
        emit(AuthFailure(message: response.message));
      }
    } on ApiException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> _onVerifyForgotOtp(
    VerifyForgotOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.verifyForgotOtp(
        email: event.email,
        activationCode: event.activationCode,
      );

      if (response.success) {
        emit(VerifyOtpSuccess(message: response.message));
      } else {
        emit(AuthFailure(message: response.message));
      }
    } on ApiException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> _onChangePassword(
    ChangePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.changePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );

      if (response.success) {
        emit(ChangePasswordSuccess(message: response.message));
      } else {
        emit(AuthFailure(message: response.message));
      }
    } on ApiException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'Something went wrong. Please try again.'));
    }
  }
}
