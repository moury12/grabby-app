part of 'auth_bloc.dart';

abstract class AuthEvent {}

class RegisterCustomerEvent extends AuthEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final bool termsAccepted;

  RegisterCustomerEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.termsAccepted,
  });
}
