import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/shared/models/base_model.dart';

abstract interface class NotificationsRepository {
  Future<Result<Map<String, dynamic>, Failure>> fetchPage(int page);
  Future<Result<int, Failure>> fetchUnreadCount();
  Future<Result<BaseModel?, Failure>> deleteOne(String id);
  Future<Result<BaseModel?, Failure>> deleteAll();
}
