import 'package:injectable/injectable.dart';

import '../../../../../core/network/network_request.dart';
import '../../../../../core/network/network_service.dart';
import '../../entity/static_pages_enum.dart';

abstract interface class StaticPagesRemoteDataSource {
  Future<String> fetch(StaticPageTypeEnum pageType);
}

@LazySingleton(as: StaticPagesRemoteDataSource)
class StaticPagesRemoteDataSourceImpl implements StaticPagesRemoteDataSource {
  final NetworkService _networkService;

  StaticPagesRemoteDataSourceImpl(this._networkService);

  @override
  Future<String> fetch(StaticPageTypeEnum pageType) async {
    final response = await _networkService.callApi<String>(
      NetworkRequest(path: pageType.apiEndpoint, method: RequestMethod.get),
      mapper: (json) => json['data']['content'] as String,
    );
    return response.data;
  }
}
