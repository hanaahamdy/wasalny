import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/network_request.dart';
import '../../../../core/network/network_service.dart';
import '../../entity/create_delivery_params.dart';

abstract interface class CreateDeliveryRemoteDataSource {
  Future<String> createDelivery(CreateDeliveryParams params);
}

@LazySingleton(as: CreateDeliveryRemoteDataSource)
class CreateDeliveryRemoteDataSourceImpl
    implements CreateDeliveryRemoteDataSource {
  final NetworkService _networkService;

  CreateDeliveryRemoteDataSourceImpl(this._networkService);

  @override
  Future<String> createDelivery(CreateDeliveryParams params) async {
    final response = await _networkService.callApi<String>(
      NetworkRequest(
        path: ApiConstants.register,
        method: RequestMethod.post,
        body: params.toJson(),
        isFormData: true,
      ),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        return responseJson['message']?.toString() ?? '';
      },
    );
    return response.data;
  }
}
