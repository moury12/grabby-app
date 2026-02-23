import 'package:bloc/bloc.dart';
import '../../../../src_export.dart';
import 'package:meta/meta.dart';

part 'onboarding_splash_event.dart';
part 'onboarding_splash_state.dart';

/// The roles a user can choose on the Role Selection screen.
enum UserRole { customer, shop }

class OnboardingSplashBloc
    extends Bloc<OnboardingSplashEvent, OnboardingSplashState> {
  final OnboardingLocalDataSource localDataSource;
  UserRole selectedRole = UserRole.customer;

  OnboardingSplashBloc({required this.localDataSource})
    : super(SplashLoading()) {
    on<LoadInitialData>(_onLoadInitialData);
    on<OnboardingCompleted>(_onOnboardingCompleted);
    on<RoleSelected>(_onRoleSelected);

    // Initialize selectedRole from storage
    selectedRole = localDataSource.getUserRole() ?? UserRole.customer;
  }

  Future<void> _onLoadInitialData(
    LoadInitialData event,
    Emitter<OnboardingSplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    emit(SplashFinished());
  }

  Future<void> _onOnboardingCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingSplashState> emit,
  ) async {
    emit(ShowRoleSelection());
  }

  Future<void> _onRoleSelected(
    RoleSelected event,
    Emitter<OnboardingSplashState> emit,
  ) async {
    selectedRole = event.role;
    await localDataSource.saveUserRole(selectedRole);
    emit(RoleSelectionDone(selectedRole));
  }
}
