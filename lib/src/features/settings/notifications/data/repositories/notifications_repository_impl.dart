import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/extensions/errors/error_handler_extension.dart';
import '../../../../../core/shared/models/base_model.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_remote_data_source.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource _remoteDataSource;

  NotificationsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPage(int page) =>
      _remoteDataSource.fetchPage(page).handleCallbackWithFailure();

  @override
  Future<Result<int, Failure>> fetchUnreadCount() =>
      _remoteDataSource.fetchUnreadCount().handleCallbackWithFailure();

  @override
  Future<Result<BaseModel?, Failure>> deleteOne(String id) =>
      _remoteDataSource.deleteOne(id).handleCallbackWithFailure();

  @override
  Future<Result<BaseModel?, Failure>> deleteAll() =>
      _remoteDataSource.deleteAll().handleCallbackWithFailure();
}
