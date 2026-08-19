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

  TeamCubit({this.teamId = 0, bool initialShowMembers = true})
    : super(TeamState.initial(showMembers: initialShowMembers));

  int get _activeTeamId =>
      state.data.payload.teamId > 0 ? state.data.payload.teamId : teamId;

  Future<void> loadTeam() async {
    setLoading();
    try {
      final detailsResponse = await injector<NetworkService>()
          .callApi<TeamPayload>(
            NetworkRequest(
              method: RequestMethod.get,
              path: teamId > 0
                  ? ApiConstants.teamDetails(teamId)
                  : ApiConstants.myTeam,
            ),
            mapper: _parseDetails,
          );
      final resolvedTeamId = detailsResponse.data.teamId;
      final members = resolvedTeamId > 0
          ? (await injector<NetworkService>().callApi<List<TeamPlayer>>(
              NetworkRequest(
                method: RequestMethod.get,
                path: ApiConstants.teamMembers(resolvedTeamId),
              ),
              mapper: (json) => _parsePlayers(json, isRequest: false),
            )).data
          : const <TeamPlayer>[];
      final requestsResponse = await injector<NetworkService>()
          .callApi<List<TeamPlayer>>(
            NetworkRequest(
              method: RequestMethod.get,
              path: ApiConstants.teamRequests(teamId),
            ),
            mapper: (json) => _parsePlayers(json, isRequest: true),
          );
      final payload = detailsResponse.data.copyWith(
        members: members,
        requests: requestsResponse.data,
        membersCount: detailsResponse.data.membersCount > 0
            ? detailsResponse.data.membersCount
            : members.length,
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
    final resolvedTeamId = _activeTeamId;
    if (resolvedTeamId <= 0) {
      setError(errorMessage: LocaleKeys.serverError, showToast: true);
      return false;
    }
    try {
      await injector<NetworkService>().callApi<dynamic>(
        NetworkRequest(
          method: RequestMethod.post,
          path: ApiConstants.substituteTeamMember(resolvedTeamId),
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
      logo: (data['logo'] ?? data['image'])?.toString() ?? '',
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
