import 'package:multiple_result/multiple_result.dart';

import '../../../error/failure.dart';

abstract interface class UserRepository {
  Future<Result<String, Failure>> logout();
}
