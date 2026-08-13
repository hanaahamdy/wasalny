part of '../imports/view_imports.dart';

class TeamTabView extends StatefulWidget {
  final int teamId;
  final bool initialShowMembers;

  const TeamTabView({
    super.key,
    this.teamId = 5,
    this.initialShowMembers = true,
  });

  @override
  State<TeamTabView> createState() => _TeamTabViewState();
}

class _TeamTabViewState extends State<TeamTabView> {
  late final TeamCubit _cubit = TeamCubit(
    teamId: widget.teamId,
    initialShowMembers: widget.initialShowMembers,
  )..loadTeam();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _respondToRequest(
    TeamPlayer player, {
    required bool accept,
  }) async {
    final success = await _cubit.respondToRequest(player.id, accept: accept);
    if (!success || !mounted || !accept) return;
    await successDialog(
      context: context,
      title: LocaleKeys.teamJoinAcceptedSuccessfully,
    );
  }

  Future<void> _showSubstitutePicker(TeamPlayer outgoingPlayer) async {
    final requests = _cubit.state.data.payload.requests;
    if (requests.isEmpty) {
      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.teamNoJoinRequests,
      );
      return;
    }

    await showDefaultBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.teamSubstitute,
            style: const TextStyle().setMainTextColor.s16.semiBold,
          ),
          16.h.szH,
          ...requests.map(
            (request) => ListTile(
              leading: const Icon(
                Icons.swap_horiz_rounded,
                color: AppColors.teamHeaderAccent,
              ),
              title: Text(request.name),
              subtitle: request.city.isEmpty ? null : Text(request.city),
              onTap: () async {
                Go.back();
                final success = await _cubit.substituteMember(
                  outgoingUserId: outgoingPlayer.userId,
                  joinRequestId: request.id,
                );
                if (!success || !mounted) return;
                MessageUtils.showSnackBar(
                  context: context,
                  baseStatus: BaseStatus.success,
                  message: LocaleKeys.dataUpdatedSuccessfully,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<TeamCubit, AsyncState<TeamState>>(
                builder: (context, state) {
                  final teamState = state.data;
                  return Column(
                    children: [
                      TeamHeaderWidget(payload: teamState.payload),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(
                            AppPadding.pW14,
                            AppPadding.pH16,
                            AppPadding.pW14,
                            AppPadding.pH20,
                          ),
                          child: Column(
                            spacing: AppMargin.mH14,
                            children: [
                              TeamSegmentedTabs(
                                showMembers: teamState.showMembers,
                                onChanged: context.read<TeamCubit>().selectTab,
                              ),
                              _buildTeamContent(state),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamContent(AsyncState<TeamState> state) {
    final teamState = state.data;
    return switch ((
      state.isLoading,
      state.errorMessage,
      teamState.showMembers,
    )) {
      (true, _, _) => Padding(
        padding: EdgeInsets.only(top: 48.h),
        child: const LoadingIndicator(color: AppColors.primary),
      ),
      (_, final message?, _) => Padding(
        padding: EdgeInsets.only(top: 48.h),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle().setMainTextColor.s14.medium,
        ),
      ),
      (_, _, true) when teamState.payload.members.isEmpty => _TeamEmptyState(
        key: const ValueKey('empty-members'),
        message: LocaleKeys.teamNoMembers,
      ),
      (_, _, false) when teamState.payload.requests.isEmpty => _TeamEmptyState(
        key: const ValueKey('empty-requests'),
        message: LocaleKeys.teamNoJoinRequests,
      ),
      (_, _, true) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: Column(
          key: const ValueKey('members'),
          spacing: AppMargin.mH12,
          children: teamState.payload.members
              .asMap()
              .entries
              .map(
                (entry) => TeamMemberCardWidget(
                  player: entry.value,
                  number: entry.key + 1,
                  onSubstitute: () => _showSubstitutePicker(entry.value),
                ),
              )
              .toList(),
        ),
      ),
      _ => AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: Column(
          key: const ValueKey('requests'),
          spacing: AppMargin.mH12,
          children: teamState.payload.requests
              .map(
                (player) => TeamRequestCardWidget(
                  player: player,
                  onAccept: () => _respondToRequest(player, accept: true),
                  onReject: () => _respondToRequest(player, accept: false),
                ),
              )
              .toList(),
        ),
      ),
    };
  }
}

class _TeamEmptyState extends StatelessWidget {
  final String message;

  const _TeamEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.h),
      child: Column(
        children: [
          Container(
            width: 72.r,
            height: 72.r,
            decoration: const BoxDecoration(
              color: AppColors.teamSubstituteBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.group_outlined,
              color: AppColors.teamHeaderAccent,
              size: 34.r,
            ),
          ),
          16.h.szH,
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle().setHintColor.s14.medium,
          ),
        ],
      ),
    );
  }
}
