part of '../../../stadiums/presentation/imports/stadiums_imports.dart';

class StadiumHomePayload {
  final List<SportCategory> sports;
  final List<Stadium> stadiums;
  final bool canCreateTeam;
  final int unreadNotificationsCount;

  const StadiumHomePayload({
    required this.sports,
    required this.stadiums,
    this.canCreateTeam = false,
    this.unreadNotificationsCount = 0,
  });

  factory StadiumHomePayload.fromJson(Map<String, dynamic> json) {
    final data = _jsonMap(json['data']);
    return StadiumHomePayload(
      sports: _jsonList(data['sports']).map(SportCategory.fromJson).toList(),
      stadiums: _jsonList(data['stadiums']).map(Stadium.fromListJson).toList(),
      canCreateTeam: data['can_create_team'] == true,
      unreadNotificationsCount: _jsonInt(data['unread_notifications_count']),
    );
  }
}
