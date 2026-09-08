import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/extensions/errors/error_handler_extension.dart';
import '../../domain/repositories/static_pages_repository.dart';
import '../../entity/static_pages_enum.dart';
import '../datasources/static_pages_remote_data_source.dart';

@LazySingleton(as: StaticPagesRepository)
class StaticPagesRepositoryImpl implements StaticPagesRepository {
  final StaticPagesRemoteDataSource _remoteDataSource;

  StaticPagesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<String, Failure>> fetch(StaticPageTypeEnum pageType) {
    return _remoteDataSource.fetch(pageType).handleCallbackWithFailure();
  }
}
