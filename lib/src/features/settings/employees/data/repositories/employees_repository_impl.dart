import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/extensions/errors/error_handler_extension.dart';
import '../../../../../core/shared/models/employee_type.dart';
import '../../domain/repositories/employees_repository.dart';
import '../../entity/employee_model.dart';
import '../datasources/employees_remote_data_source.dart';

@LazySingleton(as: EmployeesRepository)
class EmployeesRepositoryImpl implements EmployeesRepository {
  final EmployeesRemoteDataSource _remoteDataSource;

  EmployeesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<EmployeeModel>, Failure>> fetchEmployees(
    EmployeeType type,
  ) => _remoteDataSource.fetchEmployees(type).handleCallbackWithFailure();

  @override
  Future<Result<EmployeeModel, Failure>> fetchEmployee(int id) =>
      _remoteDataSource.fetchEmployee(id).handleCallbackWithFailure();

  @override
  Future<Result<EmployeeModel, Failure>> updateEmployee(int id, String name) =>
      _remoteDataSource.updateEmployee(id, name).handleCallbackWithFailure();

  @override
  Future<Result<void, Failure>> deleteEmployee(int id) =>
      _remoteDataSource.deleteEmployee(id).handleCallbackWithFailure();
}
