import 'package:injectable/injectable.dart';

import '../../../../../../../core/network/api_endpoints.dart';
import '../../../../../../../core/network/network_request.dart';
import '../../../../../../../core/network/network_service.dart';
import '../../entity/delivery_home_model.dart';

abstract interface class DeliveryHomeRemoteDataSource {
  Future<DeliveryHomeModel> fetchHome();
}

@LazySingleton(as: DeliveryHomeRemoteDataSource)
class DeliveryHomeRemoteDataSourceImpl implements DeliveryHomeRemoteDataSource {
  final NetworkService _networkService;

  DeliveryHomeRemoteDataSourceImpl(this._networkService);

  @override
  Future<DeliveryHomeModel> fetchHome() async {
    final response = await _networkService.callApi<DeliveryHomeModel>(
      NetworkRequest(path: ApiConstants.home, method: RequestMethod.get),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        final data = Map<String, dynamic>.from(responseJson['data'] as Map);
        return DeliveryHomeModel.fromJson(data);
      },
    );
    return response.data;
  }
}
