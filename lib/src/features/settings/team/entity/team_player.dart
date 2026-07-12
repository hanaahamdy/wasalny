part of '../presentation/imports/view_imports.dart';

class TeamPlayer extends Equatable {
  final String name;
  final String city;
  final String? role;
  final Color avatarColor;

  const TeamPlayer({
    required this.name,
    required this.city,
    required this.avatarColor,
    this.role,
  });

  @override
  List<Object?> get props => [name, city, role, avatarColor];
}

class TeamPayload extends Equatable {
  final List<TeamPlayer> members;
  final List<TeamPlayer> requests;

  const TeamPayload({this.members = const [], this.requests = const []});

  @override
  List<Object?> get props => [members, requests];
}
