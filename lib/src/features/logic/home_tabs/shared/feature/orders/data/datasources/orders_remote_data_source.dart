import '../../../../../../../../core/network/api_endpoints.dart';
import '../../../../../../../../core/network/network_request.dart';
import '../../../../../../../../core/network/network_service.dart';

import '../../entity/order_model.dart';

abstract interface class OrdersRemoteDataSource {
  Future<List<OrderModel>> fetchOrders({required bool isAdmin});
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final NetworkService _networkService;

  OrdersRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<OrderModel>> fetchOrders({required bool isAdmin}) async {
    final response = await _networkService.callApi<List<OrderModel>>(
      NetworkRequest(
        path: isAdmin ? ApiConstants.orders : ApiConstants.deliveryOrders,
        method: RequestMethod.get,
      ),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        final data = responseJson['data'];
        if (data is! List) return const <OrderModel>[];
        return data
            .whereType<Map>()
            .map(
              (order) => OrderModel.fromJson(Map<String, dynamic>.from(order)),
            )
            .toList();
      },
    );
    return response.data;
  }
}
