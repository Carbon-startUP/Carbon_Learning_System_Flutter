import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/auth/auth_state.dart';
import '../../data/repositories/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    if (username.trim().isEmpty) {
      emit(LoginError('يرجى إدخال اسم المستخدم'));
      return;
    }

    if (password.trim().isEmpty) {
      emit(LoginError('يرجى إدخال كلمة المرور'));
      return;
    }

    emit(LoginLoading());

    final result = await _authRepository.login(username, password);

    result.fold((error) => emit(LoginError(error)), (user) {
      final userRole = _getUserRoleFromString(user.userType);
      emit(LoginSuccess('تم تسجيل الدخول بنجاح', user, userRole));
    });
  }

  UserRole _getUserRoleFromString(String? userType) {
    switch (userType?.toLowerCase()) {
      case 'student':
        return UserRole.student;
      case 'parent':
        return UserRole.parent;
      default:
        return UserRole.unknown;
    }
  }

  void resetState() {
    emit(LoginInitial());
  }
}
