import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../core/error/failure.dart';
import '../../entity/delivery_home_model.dart';

abstract interface class DeliveryHomeRepository {
  Future<Result<DeliveryHomeModel, Failure>> fetchHome();
}
