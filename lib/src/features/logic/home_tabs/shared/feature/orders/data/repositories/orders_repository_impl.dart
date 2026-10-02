import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../../core/error/failure.dart';
import '../../../../../../../../core/extensions/errors/error_handler_extension.dart';
import '../../../../../../../../core/shared/models/base_model.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../entity/order_model.dart';
import '../datasources/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<OrderModel>, Failure>> fetchOrders({
    required bool isAdmin,
    String? status,
  }) {
    return _remoteDataSource
        .fetchOrders(isAdmin: isAdmin, status: status)
        .handleCallbackWithFailure();
  }

  @override
  Future<Result<BaseModel?, Failure>> updateDeliveryOrderStatus({
    required int orderId,
    required String status,
  }) {
    return _remoteDataSource
        .updateDeliveryOrderStatus(orderId: orderId, status: status)
        .handleCallbackWithFailure();
  }
}
