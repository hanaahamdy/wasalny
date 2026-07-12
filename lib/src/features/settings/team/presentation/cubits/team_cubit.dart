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
  TeamCubit({bool initialShowMembers = true})
    : super(TeamState.initial(showMembers: initialShowMembers));

  Future<void> loadTeam() async {
    setLoading();
    try {
      final payload = await _FakeTeamApi.getTeamPayload();
      setSuccess(data: state.data.copyWith(payload: payload));
    } catch (error) {
      setError(errorMessage: error.toString(), showToast: false);
    }
  }

  void selectTab(bool showMembers) {
    updateData(state.data.copyWith(showMembers: showMembers));
  }
}
