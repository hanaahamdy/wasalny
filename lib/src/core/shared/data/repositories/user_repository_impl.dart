import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../error/failure.dart';
import '../../../extensions/errors/error_handler_extension.dart';
import '../../domain/repositories/user_repository.dart';
import '../../models/user_model.dart';
import '../datasources/user_remote_data_source.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<UserModel?, Failure>> fetchProfile() {
    return _remoteDataSource.fetchProfile().handleCallbackWithFailure();
  }
}
