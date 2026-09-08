import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/extensions/errors/error_handler_extension.dart';
import '../../../../core/shared/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../entity/login_params.dart';
import '../datasources/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<UserModel, Failure>> login(LoginParams params) {
    return _remoteDataSource.login(params).handleCallbackWithFailure();
  }

  @override
  Future<Result<String, Failure>> forgotPassword(String email) {
    return _remoteDataSource.forgotPassword(email).handleCallbackWithFailure();
  }

  @override
  Future<Result<String, Failure>> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) {
    return _remoteDataSource
        .resetPassword(email: email, otp: otp, password: password)
        .handleCallbackWithFailure();
  }
}
