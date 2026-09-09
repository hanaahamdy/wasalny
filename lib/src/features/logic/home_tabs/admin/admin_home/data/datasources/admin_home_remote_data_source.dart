import 'package:injectable/injectable.dart';

import '../../../../../../../core/network/api_endpoints.dart';
import '../../../../../../../core/network/network_request.dart';
import '../../../../../../../core/network/network_service.dart';
import '../../entity/admin_home_model.dart';

abstract interface class AdminHomeRemoteDataSource {
  Future<AdminHomeModel> fetchHome();
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
}
