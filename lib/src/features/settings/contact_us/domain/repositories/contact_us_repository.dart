import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/shared/models/base_model.dart';
import '../../entity/contact_us_params.dart';

abstract interface class ContactUsRepository {
  Future<Result<BaseModel?, Failure>> send(ContactUsParams params);
}
