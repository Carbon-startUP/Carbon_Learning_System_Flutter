import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/api/api_service.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final ApiService _apiService;
  final FlutterSecureStorage _secureStorage;

  AuthRemoteDataSource(this._apiService, this._secureStorage);

  Future<Either<String, UserModel>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await _apiService.login(username, password);
      if (response.statusCode == 200 && response.data['success'] == true) {
        final user = UserModel.fromJson(response.data);
        await _secureStorage.write(
          key: 'sessionToken',
          value: user.sessionToken,
        );
        return Right(user);
      } else {
        return Left(response.data['message'] ?? 'فشل تسجيل الدخول');
      }
    } on DioException catch (e) {
      print('DioException Response: ${e.response}');
      print('DioException Data: ${e.response?.data}');
      print('DioException Type: ${e.type}');

      if (e.response != null) {
        if (e.response?.data is Map<String, dynamic>) {
          final Map<String, dynamic> errorData = e.response!.data;
          if (errorData.containsKey('errors') && errorData['errors'] is Map) {
            final Map<String, dynamic> errors = errorData['errors'];
            if (errors.isNotEmpty) {
              final firstErrorField = errors.keys.first;
              if (errors[firstErrorField] is List &&
                  (errors[firstErrorField] as List).isNotEmpty) {
                return Left((errors[firstErrorField] as List).first);
              }
            }
          }
          return Left(errorData['message'] ?? 'حدث خطأ غير متوقع');
        } else {
          return Left(e.response?.data.toString() ?? 'حدث خطأ في الخادم');
        }
      } else {
        return const Left(
          'فشل الاتصال بالخادم، يرجى التحقق من اتصالك بالإنترنت',
        );
      }
    } catch (e) {
      print('Generic Exception: $e'); // اطبع أي خطأ آخر
      return Left('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }
}
