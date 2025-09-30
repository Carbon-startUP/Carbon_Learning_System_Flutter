import '../../../../core/auth/auth_state.dart';
import '../../data/models/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;
  final String message;
  final UserRole userRole;

  LoginSuccess(this.message, this.user, this.userRole);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}
