part of '../presentation/imports/view_imports.dart';

class TeamPlayer extends Equatable {
  final int id;
  final int userId;
  final String name;
  final String city;
  final String? role;
  final String? roleValue;
  final Color avatarColor;

  const TeamPlayer({
    required this.id,
    required this.userId,
    required this.name,
    required this.city,
    required this.avatarColor,
    this.role,
    this.roleValue,
  });

  factory TeamPlayer.fromMemberJson(Map<String, dynamic> json) {
    final user = json['user'] is Map
        ? Map<String, dynamic>.from(json['user'] as Map)
        : const <String, dynamic>{};
    final role = json['role'] is Map
        ? Map<String, dynamic>.from(json['role'] as Map)
        : const <String, dynamic>{};
    return TeamPlayer(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      userId: int.tryParse(user['id']?.toString() ?? '') ?? 0,
      name: user['name']?.toString() ?? '',
      city: user['city'] is Map
          ? (user['city'] as Map)['name']?.toString() ?? ''
          : user['city']?.toString() ?? '',
      role: role['label']?.toString(),
      roleValue: role['value']?.toString(),
      avatarColor: AppColors.avatarBackground,
    );
  }

  factory TeamPlayer.fromRequestJson(Map<String, dynamic> json) {
    final user = json['user'] is Map
        ? Map<String, dynamic>.from(json['user'] as Map)
        : json;
    return TeamPlayer(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      userId: int.tryParse(user['id']?.toString() ?? '') ?? 0,
      name: user['name']?.toString() ?? '',
      city: user['city'] is Map
          ? (user['city'] as Map)['name']?.toString() ?? ''
          : user['city']?.toString() ?? '',
      avatarColor: AppColors.avatarBackground,
    );
  }

  bool get isCaptain => roleValue == 'captain';

  @override
  List<Object?> get props => [
    id,
    userId,
    name,
    city,
    role,
    roleValue,
    avatarColor,
  ];
}

class TeamPayload extends Equatable {
  final int teamId;
  final String name;
  final String logo;
  final int membersCount;
  final List<TeamPlayer> members;
  final List<TeamPlayer> requests;

  const TeamPayload({
    this.teamId = 0,
    this.name = '',
    this.logo = '',
    this.membersCount = 0,
    this.members = const [],
    this.requests = const [],
  });

  TeamPayload copyWith({
    int? teamId,
    String? name,
    String? logo,
    int? membersCount,
    List<TeamPlayer>? members,
    List<TeamPlayer>? requests,
  }) => TeamPayload(
    teamId: teamId ?? this.teamId,
    name: name ?? this.name,
    logo: logo ?? this.logo,
    membersCount: membersCount ?? this.membersCount,
    members: members ?? this.members,
    requests: requests ?? this.requests,
  );

  @override
  List<Object?> get props => [
    teamId,
    name,
    logo,
    membersCount,
    members,
    requests,
  ];
}
