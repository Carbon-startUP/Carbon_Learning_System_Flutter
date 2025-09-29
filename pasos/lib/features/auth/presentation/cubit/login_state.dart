import 'package:pasos/core/auth/auth_state.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  final UserRole userRole;
  LoginSuccess(this.message, this.userRole);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
