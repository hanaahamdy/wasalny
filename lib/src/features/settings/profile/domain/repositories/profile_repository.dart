import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/shared/models/base_model.dart';
import '../../../../../core/shared/models/user_model.dart';
import '../../entity/update_profile_params.dart';

abstract interface class ProfileRepository {
  Future<Result<UserModel?, Failure>> updateProfile(
    UpdateProfileParams params,
    UserModel fallback,
  );
  Future<Result<BaseModel?, Failure>> changePassword({
    required String currentPassword,
    required String password,
    required String confirmPassword,
  });
}
