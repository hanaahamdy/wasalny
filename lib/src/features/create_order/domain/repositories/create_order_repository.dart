import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failure.dart';
import '../../entity/create_order_params.dart';
import '../../entity/created_order_model.dart';

abstract interface class CreateOrderRepository {
  Future<Result<CreateOrderResponse, Failure>> createOrder(
    CreateOrderParams params,
  );
}
