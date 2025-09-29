import 'package:equatable/equatable.dart';

enum UserRole { student, parent, unknown }

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final UserRole userRole;

  const Authenticated(this.userRole);

  @override
  List<Object> get props => [userRole];
}

class Unauthenticated extends AuthState {}
