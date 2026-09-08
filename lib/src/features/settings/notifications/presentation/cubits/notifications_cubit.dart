part of '../imports/view_imports.dart';

@injectable
class NotificationsCubit extends PaginatedCubit<NotificationEntity> {
  final NotificationsRepository _repository;

  NotificationsCubit({NotificationsRepository? repository})
    : _repository = repository ?? injector<NotificationsRepository>();

  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? key,
  }) async {
    return _repository.fetchPage(page);
  }

  @override
  List<NotificationEntity> parseItems(json) => (json['data'] as List)
      .map((e) => NotificationEntity.fromJson(e))
      .toList();

  @override
  PaginationMeta parsePagination(json) =>
      PaginationMeta.fromJson(json['pagination']);

  void clearData() async {
    replaceData(PaginatedData.initial());
  }

  void deleteOneNotification(NotificationEntity notification) async {
    final updatedItems = List<NotificationEntity>.from(state.data.items)
      ..removeWhere((element) => element.id == notification.id);
    replaceData(state.data.copyWith(items: updatedItems));
  }
}
