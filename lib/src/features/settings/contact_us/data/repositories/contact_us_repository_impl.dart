import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/extensions/errors/error_handler_extension.dart';
import '../../../../../core/shared/models/base_model.dart';
import '../../domain/repositories/contact_us_repository.dart';
import '../../entity/contact_us_params.dart';
import '../datasources/contact_us_remote_data_source.dart';

@LazySingleton(as: ContactUsRepository)
class ContactUsRepositoryImpl implements ContactUsRepository {
  final ContactUsRemoteDataSource _remoteDataSource;

  ContactUsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<BaseModel?, Failure>> send(ContactUsParams params) {
    return _remoteDataSource.send(params).handleCallbackWithFailure();
  }
}
