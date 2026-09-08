import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/extensions/errors/error_handler_extension.dart';
import '../../domain/repositories/create_order_repository.dart';
import '../../entity/create_order_params.dart';
import '../../entity/created_order_model.dart';
import '../datasources/create_order_remote_data_source.dart';

@LazySingleton(as: CreateOrderRepository)
class CreateOrderRepositoryImpl implements CreateOrderRepository {
  final CreateOrderRemoteDataSource _remoteDataSource;

  CreateOrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<CreateOrderResponse, Failure>> createOrder(
    CreateOrderParams params,
  ) {
    return _remoteDataSource.createOrder(params).handleCallbackWithFailure();
  }
}
