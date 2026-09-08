import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/network_request.dart';
import '../../../../../core/network/network_service.dart';
import '../../../../../core/shared/models/base_model.dart';
import '../../entity/contact_us_params.dart';

abstract interface class ContactUsRemoteDataSource {
  Future<BaseModel?> send(ContactUsParams params);
}

@LazySingleton(as: ContactUsRemoteDataSource)
class ContactUsRemoteDataSourceImpl implements ContactUsRemoteDataSource {
  final NetworkService _networkService;

  ContactUsRemoteDataSourceImpl(this._networkService);

  @override
  Future<BaseModel?> send(ContactUsParams params) async {
    final response = await _networkService.callApi<BaseModel?>(
      NetworkRequest(
        path: ApiConstants.contactUs,
        method: RequestMethod.post,
        body: params.toJson(),
      ),
      mapper: (json) => BaseModel.fromJson(json),
    );
    return response.data;
  }
}
