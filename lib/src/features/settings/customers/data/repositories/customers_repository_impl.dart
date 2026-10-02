import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/extensions/errors/error_handler_extension.dart';
import '../../domain/repositories/customers_repository.dart';
import '../../entity/customer.dart';
import '../datasources/customers_remote_data_source.dart';

@LazySingleton(as: CustomersRepository)
class CustomersRepositoryImpl implements CustomersRepository {
  final CustomersRemoteDataSource _remoteDataSource;

  CustomersRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<Customer>, Failure>> fetchClients({
    String? name,
    String? phone,
  }) => _remoteDataSource
      .fetchClients(name: name, phone: phone)
      .handleCallbackWithFailure();
}
