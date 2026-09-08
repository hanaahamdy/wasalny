import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failure.dart';
import '../../entity/create_delivery_params.dart';

abstract interface class CreateDeliveryRepository {
  Future<Result<String, Failure>> createDelivery(CreateDeliveryParams params);
}
