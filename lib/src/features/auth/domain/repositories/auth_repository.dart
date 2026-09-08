import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/models/user_model.dart';
import '../../entity/login_params.dart';

abstract interface class AuthRepository {
  Future<Result<UserModel, Failure>> login(LoginParams params);
  Future<Result<String, Failure>> forgotPassword(String email);
  Future<Result<String, Failure>> resetPassword({
    required String email,
    required String otp,
    required String password,
  });
}
