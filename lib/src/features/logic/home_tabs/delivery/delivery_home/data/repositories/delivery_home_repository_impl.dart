import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../core/error/failure.dart';
import '../../../../../../../core/extensions/errors/error_handler_extension.dart';
import '../../domain/repositories/delivery_home_repository.dart';
import '../../entity/delivery_home_model.dart';
import '../datasources/delivery_home_remote_data_source.dart';

@LazySingleton(as: DeliveryHomeRepository)
class DeliveryHomeRepositoryImpl implements DeliveryHomeRepository {
  final DeliveryHomeRemoteDataSource _remoteDataSource;

  DeliveryHomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<DeliveryHomeModel, Failure>> fetchHome() {
    return _remoteDataSource.fetchHome().handleCallbackWithFailure();
  }
}
