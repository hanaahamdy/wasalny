part of '../imports/view_imports.dart';

class TeamState extends Equatable {
  final bool showMembers;
  final TeamPayload payload;

  const TeamState({
    this.showMembers = true,
    this.payload = const TeamPayload(),
  });

  factory TeamState.initial({bool showMembers = true}) {
    return TeamState(showMembers: showMembers);
  }

  TeamState copyWith({bool? showMembers, TeamPayload? payload}) {
    return TeamState(
      showMembers: showMembers ?? this.showMembers,
      payload: payload ?? this.payload,
    );
  }

  @override
  List<Object?> get props => [showMembers, payload];
}

class TeamCubit extends AsyncCubit<TeamState> {
  final int teamId;

  TeamCubit({required this.teamId, bool initialShowMembers = true})
    : super(TeamState.initial(showMembers: initialShowMembers));

  Future<void> loadTeam() async {
    setLoading();
    try {
      if (teamId <= 0) throw StateError('Invalid team id');
      final detailsResponse = await injector<NetworkService>()
          .callApi<TeamPayload>(
            NetworkRequest(
              method: RequestMethod.get,
              path: ApiConstants.teamDetails(teamId),
            ),
            mapper: _parseDetails,
          );
      final membersResponse = await injector<NetworkService>()
          .callApi<List<TeamPlayer>>(
            NetworkRequest(
              method: RequestMethod.get,
              path: ApiConstants.teamMembers(teamId),
            ),
            mapper: (json) => _parsePlayers(json, isRequest: false),
          );
      final requestsResponse = await injector<NetworkService>()
          .callApi<List<TeamPlayer>>(
            NetworkRequest(
              method: RequestMethod.get,
              path: ApiConstants.teamRequests(teamId),
            ),
            mapper: (json) => _parsePlayers(json, isRequest: true),
          );
      final payload = detailsResponse.data.copyWith(
        members: membersResponse.data,
        requests: requestsResponse.data,
        membersCount: membersResponse.data.length,
      );
      setSuccess(data: state.data.copyWith(payload: payload));
    } catch (error) {
      setError(errorMessage: error.toString(), showToast: false);
    }
  }

  void selectTab(bool showMembers) {
    updateData(state.data.copyWith(showMembers: showMembers));
  }

  Future<bool> respondToRequest(int requestId, {required bool accept}) async {
    try {
      await injector<NetworkService>().callApi<dynamic>(
        NetworkRequest(
          method: RequestMethod.post,
          path: accept
              ? ApiConstants.acceptTeamRequest(requestId)
              : ApiConstants.rejectTeamRequest(requestId),
        ),
        mapper: (json) => json,
      );
      await loadTeam();
      return true;
    } catch (error) {
      setError(errorMessage: error.toString(), showToast: true);
      return false;
    }
  }

  Future<bool> substituteMember({
    required int outgoingUserId,
    required int joinRequestId,
  }) async {
    try {
      await injector<NetworkService>().callApi<dynamic>(
        NetworkRequest(
          method: RequestMethod.post,
          path: ApiConstants.substituteTeamMember(teamId),
          body: {
            'outgoing_user_id': outgoingUserId,
            'join_request_id': joinRequestId,
          },
          isFormData: true,
        ),
        mapper: (json) => json,
      );
      await loadTeam();
      return true;
    } catch (error) {
      setError(errorMessage: error.toString(), showToast: true);
      return false;
    }
  }

  static TeamPayload _parseDetails(dynamic json) {
    final value = json is Map ? json['data'] : null;
    final data = value is Map
        ? Map<String, dynamic>.from(value)
        : const <String, dynamic>{};
    return TeamPayload(
      teamId: int.tryParse(data['id']?.toString() ?? '') ?? 0,
      name: data['name']?.toString() ?? '',
      logo: data['logo']?.toString() ?? '',
      membersCount: int.tryParse(data['members_count']?.toString() ?? '') ?? 0,
    );
  }

  static List<TeamPlayer> _parsePlayers(
    dynamic json, {
    required bool isRequest,
  }) {
    dynamic data = json is Map ? json['data'] : json;
    if (data is Map) data = data['data'];
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .map(isRequest ? TeamPlayer.fromRequestJson : TeamPlayer.fromMemberJson)
        .where((player) => player.id > 0)
        .toList();
  }
}
