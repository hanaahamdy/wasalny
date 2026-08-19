part of '../../presentation/imports/create_match_imports.dart';

abstract final class CreateMatchTeamMapper {
  static CreateMatchTeam fromJson(Map<String, dynamic> json) {
    final players = json['players'];
    final playersCount =
        json['players_count'] ??
        json['members_count'] ??
        (players is List ? players.length : null) ??
        0;
    return CreateMatchTeam(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      name: json['name']?.toString() ?? '',
      playersCount: playersCount.toString(),
      imagePath:
          (json['image'] ?? json['logo'] ?? json['image_url'])?.toString() ??
          '',
    );
  }

  static List<CreateMatchTeam> listFromResponse(dynamic json) {
    dynamic data = json;
    if (data is Map) data = data['data'] ?? data['teams'];
    if (data is Map) data = data['data'] ?? data['teams'];
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((team) => fromJson(Map<String, dynamic>.from(team)))
        .where((team) => team.id > 0)
        .toList();
  }
}
