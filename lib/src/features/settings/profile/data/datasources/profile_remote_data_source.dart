import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/network_request.dart';
import '../../../../../core/network/network_service.dart';
import '../../../../../core/shared/models/base_model.dart';
import '../../../../../core/shared/models/user_model.dart';
import '../../entity/update_profile_params.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel?> fetchProfile();
  Future<UserModel?> updateProfile(
    UpdateProfileParams params,
    UserModel fallback,
  );
  Future<BaseModel?> changePassword(Map<String, dynamic> body);
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final NetworkService _networkService;

  ProfileRemoteDataSourceImpl(this._networkService);

  @override
  Future<UserModel?> fetchProfile() async {
    final response = await _networkService.callApi<UserModel?>(
      NetworkRequest(path: ApiConstants.profile, method: RequestMethod.get),
      mapper: _mapUser,
    );
    return response.data;
  }

  @override
  Future<UserModel?> updateProfile(
    UpdateProfileParams params,
    UserModel fallback,
  ) async {
    final response = await _networkService.callApi<UserModel?>(
      NetworkRequest(
        path: ApiConstants.updateProfile,
        method: RequestMethod.post,
        body: params.toJson(),
        isFormData: true,
      ),
      mapper: (json) => _mapUser(json) ?? fallback,
    );
    return response.data;
  }

  @override
  Future<BaseModel?> changePassword(Map<String, dynamic> body) async {
    final response = await _networkService.callApi<BaseModel?>(
      NetworkRequest(
        path: ApiConstants.changePassword,
        method: RequestMethod.post,
        body: body,
        isFormData: true,
      ),
      mapper: (json) => BaseModel.fromJson(json),
    );
    return response.data;
  }

  UserModel? _mapUser(dynamic json) {
    final response = Map<String, dynamic>.from(json as Map);
    final data = response['data'];
    return data is Map
        ? UserModel.fromJson(Map<String, dynamic>.from(data))
        : null;
  }
}
