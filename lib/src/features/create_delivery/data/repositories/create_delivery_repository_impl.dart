import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/extensions/errors/error_handler_extension.dart';
import '../../domain/repositories/create_delivery_repository.dart';
import '../../entity/create_delivery_params.dart';
import '../datasources/create_delivery_remote_data_source.dart';

@LazySingleton(as: CreateDeliveryRepository)
class CreateDeliveryRepositoryImpl implements CreateDeliveryRepository {
  final CreateDeliveryRemoteDataSource _remoteDataSource;

  CreateDeliveryRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<String, Failure>> createDelivery(CreateDeliveryParams params) {
    return _remoteDataSource.createDelivery(params).handleCallbackWithFailure();
  }
}
