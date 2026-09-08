import 'package:injectable/injectable.dart';

import '../../../network/api_endpoints.dart';
import '../../../network/network_request.dart';
import '../../../network/network_service.dart';
import '../../models/user_model.dart';

abstract interface class UserRemoteDataSource {
  Future<UserModel?> fetchProfile();
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final NetworkService _networkService;

  UserRemoteDataSourceImpl(this._networkService);

  @override
  Future<UserModel?> fetchProfile() async {
    final response = await _networkService.callApi<UserModel?>(
      NetworkRequest(path: ApiConstants.profile, method: RequestMethod.get),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        final data = responseJson['data'];
        return data is Map
            ? UserModel.fromJson(Map<String, dynamic>.from(data))
            : null;
      },
    );
    return response.data;
  }
}
