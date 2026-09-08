import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../entity/static_pages_enum.dart';

abstract interface class StaticPagesRepository {
  Future<Result<String, Failure>> fetch(StaticPageTypeEnum pageType);
}
