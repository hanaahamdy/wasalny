import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failure.dart';
import '../../entity/create_employee_params.dart';

abstract interface class CreateEmployeeRepository {
  Future<Result<String, Failure>> createEmployee(CreateEmployeeParams params);
}
