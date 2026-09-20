import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/extensions/errors/error_handler_extension.dart';
import '../../domain/repositories/create_employee_repository.dart';
import '../../entity/create_employee_params.dart';
import '../datasources/create_employee_remote_data_source.dart';

@LazySingleton(as: CreateEmployeeRepository)
class CreateEmployeeRepositoryImpl implements CreateEmployeeRepository {
  final CreateEmployeeRemoteDataSource _remoteDataSource;

  CreateEmployeeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<String, Failure>> createEmployee(CreateEmployeeParams params) {
    return _remoteDataSource.createEmployee(params).handleCallbackWithFailure();
  }
}
