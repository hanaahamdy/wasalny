part of '../../presentation/imports/create_match_imports.dart';

abstract final class CreateMatchStadiumsPageMapper {
  static CreateMatchStadiumsPage fromResponse(dynamic json) {
    final root = json is Map ? Map<String, dynamic>.from(json) : const {};
    final payload = root['data'] is Map
        ? Map<String, dynamic>.from(root['data'] as Map)
        : const <String, dynamic>{};
    final items = payload['data'] is List ? payload['data'] as List : const [];
    final pagination = payload['pagination'] is Map
        ? Map<String, dynamic>.from(payload['pagination'] as Map)
        : const <String, dynamic>{};

    int readPage(String key) =>
        int.tryParse(pagination[key]?.toString() ?? '') ?? 1;

    return CreateMatchStadiumsPage(
      stadiums: items
          .whereType<Map>()
          .map(
            (item) => CreateMatchStadiumMapper.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .where((stadium) => stadium.id > 0)
          .toList(),
      currentPage: readPage('current_page'),
      lastPage: readPage('last_page'),
    );
  }
}
