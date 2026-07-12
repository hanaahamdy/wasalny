part of '../imports/view_imports.dart';

class TeamTabView extends StatefulWidget {
  final bool initialShowMembers;

  const TeamTabView({super.key, this.initialShowMembers = true});

  @override
  State<TeamTabView> createState() => _TeamTabViewState();
}

class _TeamTabViewState extends State<TeamTabView> {
  late final TeamCubit _cubit = TeamCubit(
    initialShowMembers: widget.initialShowMembers,
  )..loadTeam();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _acceptRequest() async {
    await successDialog(
      context: context,
      title: LocaleKeys.teamJoinAcceptedSuccessfully,
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
            const TeamHeaderWidget(),
            Expanded(
              child: BlocBuilder<TeamCubit, AsyncState<TeamState>>(
                builder: (context, state) {
                  final teamState = state.data;
                  return SingleChildScrollView(
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
                  onAccept: _acceptRequest,
                ),
              )
              .toList(),
        ),
      ),
    };
  }
}
