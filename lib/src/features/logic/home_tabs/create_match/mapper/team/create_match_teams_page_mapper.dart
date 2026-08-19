part of '../../presentation/imports/create_match_imports.dart';

abstract final class CreateMatchTeamsPageMapper {
  static CreateMatchTeamsPage fromResponse(dynamic json) {
    final root = json is Map ? Map<String, dynamic>.from(json) : const {};
    final payloadValue = root['data'];
    final payload = payloadValue is Map
        ? Map<String, dynamic>.from(payloadValue)
        : const <String, dynamic>{};
    final paginationValue = payload['pagination'];
    final pagination = paginationValue is Map
        ? Map<String, dynamic>.from(paginationValue)
        : const <String, dynamic>{};

    int readPage(String key) =>
        int.tryParse(pagination[key]?.toString() ?? '') ?? 1;

    return CreateMatchTeamsPage(
      teams: CreateMatchTeamMapper.listFromResponse(json),
      currentPage: readPage('current_page'),
      lastPage: readPage('last_page'),
    );
  }
}
