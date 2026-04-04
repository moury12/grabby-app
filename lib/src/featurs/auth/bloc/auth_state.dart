part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final String message;
  RegisterSuccess({required this.message});
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}
