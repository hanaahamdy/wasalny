import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../../core/error/failure.dart';
import '../../entity/order_model.dart';

abstract interface class OrdersRepository {
  Future<Result<List<OrderModel>, Failure>> fetchOrders({
    required bool isAdmin,
  });
}
