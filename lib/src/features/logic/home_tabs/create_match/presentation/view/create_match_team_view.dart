part of '../imports/create_match_imports.dart';

class CreateMatchTeamView extends StatefulWidget {
  final List<CreateMatchTeam>? teams;

  const CreateMatchTeamView({super.key, this.teams});

  @override
  State<CreateMatchTeamView> createState() => _CreateMatchTeamViewState();
}

class _CreateMatchTeamViewState extends State<CreateMatchTeamView> {
  final ValueNotifier<int?> _selectedTeamIdNotifier = ValueNotifier(null);
  late final CreateMatchTeamsCubit _teamsCubit = CreateMatchTeamsCubit();
  late final ScrollController _scrollController = ScrollController()
    ..addListener(_onScroll);
  List<CreateMatchTeam> _teams = const [];

  void _onScroll() {
    if (_scrollController.position.extentAfter < 250) {
      _teamsCubit.fetchMoreTeams();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.teams != null) {
      _teams = widget.teams!;
    } else {
      _teamsCubit.fetchTeams();
    }
  }

  Future<void> _continueWithSelectedTeam() async {
    final selectedTeam = _teams.firstWhere(
      (team) => team.id == _selectedTeamIdNotifier.value,
    );
    Go.to(CreateMatchStadiumView(team: selectedTeam));
  }

  @override
  void dispose() {
    _selectedTeamIdNotifier.dispose();
    _scrollController.dispose();
    _teamsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.createMatchHeader,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: BlocProvider.value(
        value: _teamsCubit,
        child: Scaffold(
          appBar: CustomAppbar(title: LocaleKeys.stadiumsCreateMatch),
          backgroundColor: AppColors.scaffoldBackground,
          body: Column(
            children: [
              Expanded(
                child:
                    BlocBuilder<
                      CreateMatchTeamsCubit,
                      AsyncState<List<CreateMatchTeam>>
                    >(
                      builder: (context, teamsState) {
                        if (widget.teams == null && teamsState.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        }
                        if (widget.teams == null && teamsState.isError) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: AppColors.error,
                                    size: 40.r,
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    teamsState.errorMessage?.isNotEmpty == true
                                        ? teamsState.errorMessage!
                                        : LocaleKeys.exceptionError,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.hintText,
                                      fontSize: 13.sp,
                                      height: 1.6,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  TextButton(
                                    onPressed: _teamsCubit.fetchTeams,
                                    child: Text(LocaleKeys.stadiumsRetry),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        if (widget.teams == null) _teams = teamsState.data;
                        return ValueListenableBuilder<int?>(
                          valueListenable: _selectedTeamIdNotifier,
                          builder: (context, selectedTeamId, _) {
                            return ListView(
                              controller: _scrollController,
                              padding: EdgeInsets.fromLTRB(
                                16.w,
                                20.h,
                                16.w,
                                24.h,
                              ),
                              children: [
                                Text(
                                  LocaleKeys.createMatchChooseTeam,
                                  style: TextStyle(
                                    color: AppColors.notificationText,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                ..._teams.map(
                                  (team) => Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: CreateMatchTeamCard(
                                      team: team,
                                      isSelected: selectedTeamId == team.id,
                                      onTap: () =>
                                          _selectedTeamIdNotifier.value =
                                              team.id,
                                    ),
                                  ),
                                ),
                                if (teamsState.isLoadingMore)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    ),
              ),
              ValueListenableBuilder<int?>(
                valueListenable: _selectedTeamIdNotifier,
                builder: (context, selectedTeamId, _) {
                  return CreateMatchBottomAction(
                    enabled: selectedTeamId != null && selectedTeamId > 0,
                    onNext: _continueWithSelectedTeam,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
