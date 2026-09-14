import 'package:injectable/injectable.dart';

import '../../../../../../../core/network/api_endpoints.dart';
import '../../../../../../../core/network/network_request.dart';
import '../../../../../../../core/network/network_service.dart';
import '../../entity/admin_home_model.dart';
import '../../../../shared/feature/orders/entity/order_model.dart';

abstract interface class AdminHomeRemoteDataSource {
  Future<AdminHomeModel> fetchHome();
  Future<OrderModel> fetchOrderDetails(int orderId);
}

@LazySingleton(as: AdminHomeRemoteDataSource)
class AdminHomeRemoteDataSourceImpl implements AdminHomeRemoteDataSource {
  final NetworkService _networkService;

  AdminHomeRemoteDataSourceImpl(this._networkService);

  @override
  Future<AdminHomeModel> fetchHome() async {
    final response = await _networkService.callApi<AdminHomeModel>(
      NetworkRequest(path: ApiConstants.home, method: RequestMethod.get),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        final data = Map<String, dynamic>.from(responseJson['data'] as Map);
        return AdminHomeModel.fromJson(data);
      },
    );
    return response.data;
  }

  @override
  Future<OrderModel> fetchOrderDetails(int orderId) async {
    final response = await _networkService.callApi<OrderModel>(
      NetworkRequest(
        path: ApiConstants.orderDetails(orderId),
        method: RequestMethod.get,
      ),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        final data = Map<String, dynamic>.from(responseJson['data'] as Map);
        return OrderModel.fromJson(data);
      },
    );
    return response.data;
  }
}
