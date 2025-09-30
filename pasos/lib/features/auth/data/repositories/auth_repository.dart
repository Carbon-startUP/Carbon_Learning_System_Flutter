import 'package:dartz/dartz.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepository(this._remoteDataSource);

  Future<Either<String, UserModel>> login(String username, String password) {
    return _remoteDataSource.login(username, password);
  }
}
