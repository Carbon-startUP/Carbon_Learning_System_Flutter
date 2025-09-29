import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Unauthenticated());

  void login(UserRole role) {
    emit(Authenticated(role));
  }

  void logout() {
    emit(Unauthenticated());
  }
}
