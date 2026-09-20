import 'package:injectable/injectable.dart';

import '../../../network/api_endpoints.dart';
import '../../../network/network_request.dart';
import '../../../network/network_service.dart';

abstract interface class UserRemoteDataSource {
  Future<String> logout();
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final NetworkService _networkService;

  UserRemoteDataSourceImpl(this._networkService);

  @override
  Future<String> logout() async {
    final response = await _networkService.callApi<String>(
      NetworkRequest(path: ApiConstants.logOut, method: RequestMethod.post),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        return responseJson['message']?.toString() ?? '';
      },
    );
    return response.data;
  }
}
