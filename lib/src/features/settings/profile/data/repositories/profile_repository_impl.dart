import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/extensions/errors/error_handler_extension.dart';
import '../../../../../core/shared/models/base_model.dart';
import '../../../../../core/shared/models/user_model.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../entity/update_profile_params.dart';
import '../datasources/profile_remote_data_source.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<UserModel?, Failure>> updateProfile(
    UpdateProfileParams params,
    UserModel fallback,
  ) {
    return _remoteDataSource
        .updateProfile(params, fallback)
        .handleCallbackWithFailure();
  }

  @override
  Future<Result<BaseModel?, Failure>> changePassword({
    required String currentPassword,
    required String password,
    required String confirmPassword,
  }) {
    return _remoteDataSource.changePassword({
      'current_password': currentPassword,
      'password': password,
      'password_confirmation': confirmPassword,
    }).handleCallbackWithFailure();
  }
}
