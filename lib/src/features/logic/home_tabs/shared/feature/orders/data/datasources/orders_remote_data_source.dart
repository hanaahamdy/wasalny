import '../../../../../../../../core/network/api_endpoints.dart';
import '../../../../../../../../core/network/network_request.dart';
import '../../../../../../../../core/network/network_service.dart';
import '../../../../../../../../core/shared/models/base_model.dart';

import '../../entity/order_model.dart';

abstract interface class OrdersRemoteDataSource {
  Future<List<OrderModel>> fetchOrders({required bool isAdmin, String? status});
  Future<BaseModel?> updateDeliveryOrderStatus({
    required int orderId,
    required String status,
  });
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final NetworkService _networkService;

  OrdersRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<OrderModel>> fetchOrders({
    required bool isAdmin,
    String? status,
  }) async {
    final response = await _networkService.callApi<List<OrderModel>>(
      NetworkRequest(
        path: isAdmin ? ApiConstants.orders : ApiConstants.deliveryOrders,
        method: RequestMethod.get,
        queryParameters: status == null ? null : {'status': status},
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

  @override
  Future<BaseModel?> updateDeliveryOrderStatus({
    required int orderId,
    required String status,
  }) async {
    final response = await _networkService.callApi<BaseModel?>(
      NetworkRequest(
        path: ApiConstants.deliveryOrderStatus(orderId),
        method: RequestMethod.patch,
        queryParameters: {'status': status},
        body: const {},
        isFormData: true,
      ),
      mapper: (json) => BaseModel.fromJson(json),
    );
    return response.data;
  }
}
