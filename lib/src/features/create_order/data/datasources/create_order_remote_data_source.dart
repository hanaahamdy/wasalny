import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/network_request.dart';
import '../../../../core/network/network_service.dart';
import '../../entity/create_order_params.dart';
import '../../entity/created_order_model.dart';

abstract interface class CreateOrderRemoteDataSource {
  Future<CreateOrderResponse> createOrder(CreateOrderParams params);
}

@LazySingleton(as: CreateOrderRemoteDataSource)
class CreateOrderRemoteDataSourceImpl implements CreateOrderRemoteDataSource {
  final NetworkService _networkService;

  CreateOrderRemoteDataSourceImpl(this._networkService);

  @override
  Future<CreateOrderResponse> createOrder(CreateOrderParams params) async {
    final response = await _networkService.callApi<CreateOrderResponse>(
      NetworkRequest(
        path: ApiConstants.orders,
        method: RequestMethod.post,
        body: params.toJson(),
        isFormData: true,
      ),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        final data = Map<String, dynamic>.from(responseJson['data'] as Map);
        return CreateOrderResponse(
          message: responseJson['message']?.toString() ?? '',
          order: CreatedOrderModel.fromJson(data),
        );
      },
    );
    return response.data;
  }
}
