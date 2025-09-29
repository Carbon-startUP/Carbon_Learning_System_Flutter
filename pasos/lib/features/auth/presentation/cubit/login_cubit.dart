import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/core/auth/auth_state.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String userId, String password) async {
    try {
      emit(LoginLoading());

      if (userId.trim().isEmpty) {
        emit(LoginError('يرجى إدخال معرف المستخدم'));
        return;
      }

      if (password.trim().isEmpty) {
        emit(LoginError('يرجى إدخال كلمة المرور'));
        return;
      }

      if (password.length < 6) {
        emit(LoginError('كلمة المرور يجب أن تكون 6 أحرف على الأقل'));
        return;
      }

      await Future.delayed(const Duration(seconds: 2));

      if (password == "123456") {
        emit(LoginSuccess('تم تسجيل الدخول كطالب', UserRole.student));
      } else if (password == "654321") {
        emit(LoginSuccess('تم تسجيل الدخول كولي أمر', UserRole.parent));
      } else {
        emit(LoginError('معرف المستخدم أو كلمة المرور غير صحيحة'));
      }
    } catch (e) {
      emit(LoginError('حدث خطأ أثناء تسجيل الدخول: ${e.toString()}'));
    }
  }

  void resetState() {
    emit(LoginInitial());
  }

  Future<void> forgotPassword(String userId) async {
    try {
      emit(LoginLoading());

      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement actual forgot password logic
      emit(
        LoginSuccess(
          'تم إرسال رابط إعادة تعيين كلمة المرور'
          'إلى بريدك الإلكتروني',
          UserRole.student,
        ),
      );
    } catch (e) {
      emit(LoginError('حدث خطأ أثناء إرسال رابط إعادة التعيين'));
    }
  }
}
