import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../core/error/failure.dart';
import '../../entity/admin_home_model.dart';
import '../../../../shared/feature/orders/entity/order_model.dart';

abstract interface class AdminHomeRepository {
  Future<Result<AdminHomeModel, Failure>> fetchHome();
  Future<Result<OrderModel, Failure>> fetchOrderDetails(int orderId);
}
