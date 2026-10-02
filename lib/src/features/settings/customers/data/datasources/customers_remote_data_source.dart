import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/network_request.dart';
import '../../../../../core/network/network_service.dart';
import '../../entity/customer.dart';

abstract interface class CustomersRemoteDataSource {
  Future<List<Customer>> fetchClients({String? name, String? phone});
}

@LazySingleton(as: CustomersRemoteDataSource)
class CustomersRemoteDataSourceImpl implements CustomersRemoteDataSource {
  final NetworkService _networkService;

  CustomersRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<Customer>> fetchClients({String? name, String? phone}) async {
    final response = await _networkService.callApi<List<Customer>>(
      NetworkRequest(
        path: ApiConstants.clients,
        method: RequestMethod.get,
        queryParameters: {
          if (name?.isNotEmpty == true) 'name': name,
          if (phone?.isNotEmpty == true) 'phone': phone,
        },
      ),
      mapper: (json) {
        final data = json is Map ? json['data'] : null;
        final items = data is List
            ? data
            : data is Map && data['data'] is List
            ? data['data'] as List
            : const [];
        return items
            .whereType<Map>()
            .map((item) => Customer.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      },
    );
    return response.data;
  }
}
