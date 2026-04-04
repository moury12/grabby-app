import '../../../src_export.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<RegisterCustomerEvent>(_onRegisterCustomer);
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
}
