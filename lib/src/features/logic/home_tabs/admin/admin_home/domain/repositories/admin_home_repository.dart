import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../core/error/failure.dart';
import '../../entity/admin_home_model.dart';

abstract interface class AdminHomeRepository {
  Future<Result<AdminHomeModel, Failure>> fetchHome();
}
