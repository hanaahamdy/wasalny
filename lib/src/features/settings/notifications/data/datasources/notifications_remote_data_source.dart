import 'package:injectable/injectable.dart';

import '../../../../../config/res/config_imports.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/network_request.dart';
import '../../../../../core/network/network_service.dart';
import '../../../../../core/shared/models/base_model.dart';

abstract interface class NotificationsRemoteDataSource {
  Future<Map<String, dynamic>> fetchPage(int page);
  Future<int> fetchUnreadCount();
  Future<BaseModel?> deleteOne(String id);
  Future<BaseModel?> deleteAll();
}

@LazySingleton(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final NetworkService _networkService;

  NotificationsRemoteDataSourceImpl(this._networkService);

  @override
  Future<Map<String, dynamic>> fetchPage(int page) async {
    final response = await _networkService.callApi<Map<String, dynamic>>(
      NetworkRequest(
        path: ApiConstants.notifications,
        method: RequestMethod.get,
        queryParameters: ConstantManager.paginateJson(page),
      ),
      mapper: (json) => Map<String, dynamic>.from(json as Map),
    );
    return response.data;
  }

  @override
  Future<int> fetchUnreadCount() async {
    final response = await _networkService.callApi<int>(
      NetworkRequest(
        path: ApiConstants.unReadNotifications,
        method: RequestMethod.get,
      ),
      mapper: (json) => json['data']['count'] as int? ?? 0,
    );
    return response.data;
  }

  @override
  Future<BaseModel?> deleteOne(String id) =>
      _delete('${ApiConstants.deleteNotification}$id');

  @override
  Future<BaseModel?> deleteAll() =>
      _delete(ApiConstants.deleteAllNotifications);

  Future<BaseModel?> _delete(String path) async {
    final response = await _networkService.callApi<BaseModel?>(
      NetworkRequest(path: path, method: RequestMethod.delete),
      mapper: (json) => BaseModel.fromJson(json),
    );
    return response.data;
  }
}
