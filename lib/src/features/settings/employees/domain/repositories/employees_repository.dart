import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/shared/models/employee_type.dart';
import '../../entity/employee_model.dart';

abstract interface class EmployeesRepository {
  Future<Result<List<EmployeeModel>, Failure>> fetchEmployees(
    EmployeeType type,
  );
  Future<Result<EmployeeModel, Failure>> fetchEmployee(int id);
  Future<Result<EmployeeModel, Failure>> updateEmployee(int id, String name);
  Future<Result<void, Failure>> deleteEmployee(int id);
}
