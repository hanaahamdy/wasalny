import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../core/error/failure.dart';
import '../../../../../../../core/extensions/errors/error_handler_extension.dart';
import '../../domain/repositories/admin_home_repository.dart';
import '../../entity/admin_home_model.dart';
import '../datasources/admin_home_remote_data_source.dart';

@LazySingleton(as: AdminHomeRepository)
class AdminHomeRepositoryImpl implements AdminHomeRepository {
  final AdminHomeRemoteDataSource _remoteDataSource;

  AdminHomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<AdminHomeModel, Failure>> fetchHome() {
    return _remoteDataSource.fetchHome().handleCallbackWithFailure();
  }
}
