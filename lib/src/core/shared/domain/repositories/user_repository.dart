import 'package:multiple_result/multiple_result.dart';

import '../../../error/failure.dart';
import '../../models/user_model.dart';

abstract interface class UserRepository {
  Future<Result<UserModel?, Failure>> fetchProfile();
}
