import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../entity/customer.dart';

abstract interface class CustomersRepository {
  Future<Result<List<Customer>, Failure>> fetchClients({
    String? name,
    String? phone,
  });
}
