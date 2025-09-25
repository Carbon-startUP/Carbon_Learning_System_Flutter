import 'package:flutter_bloc/flutter_bloc.dart';
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

      // TODO: Replace with actual authentication logic
      bool isValid = await _validateCredentials(userId, password);

      if (isValid) {
        emit(LoginSuccess('تم تسجيل الدخول بنجاح'));
      } else {
        emit(LoginError('معرف المستخدم أو كلمة المرور غير صحيحة'));
      }
    } catch (e) {
      emit(LoginError('حدث خطأ أثناء تسجيل الدخول: ${e.toString()}'));
    }
  }

  Future<bool> _validateCredentials(String userId, String password) async {
    //accept any user with password "123456"
    return password == "123456" && userId.isNotEmpty;
  }

  void resetState() {
    emit(LoginInitial());
  }

  Future<void> forgotPassword(String userId) async {
    try {
      emit(LoginLoading());

      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement actual forgot password logic
      emit(LoginSuccess('تم إرسال رابط إعادة تعيين كلمة المرور'));
    } catch (e) {
      emit(LoginError('حدث خطأ أثناء إرسال رابط إعادة التعيين'));
    }
  }
}
