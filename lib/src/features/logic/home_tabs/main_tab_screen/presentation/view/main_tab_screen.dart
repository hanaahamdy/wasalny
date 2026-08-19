part of '../imports/main_tab_screen_imports.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  late final StadiumsHomeCubit _stadiumsCubit = StadiumsHomeCubit()
    ..loadHomePayload();
  late final SportsCubit _sportsCubit = SportsCubit()..loadSports();

  @override
  void dispose() {
    _stadiumsCubit.close();
    _sportsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _stadiumsCubit),
        BlocProvider.value(value: _sportsCubit),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.scaffoldBackground,
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _HomeHero(
                  onSearchTap: () => Go.to(const StadiumSearchView()),
                  onNotificationTap: () => Go.to(const NotificationScreen()),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 24.h),
                sliver: SliverList.list(
                  children: [
                    BlocBuilder<
                      StadiumsHomeCubit,
                      AsyncState<StadiumHomePayload?>
                    >(
                      builder: (context, state) => _QuickActionsRow(
                        canCreateTeam: state.data?.canCreateTeam ?? true,
                        onCreateTeam: () => Go.to(const CreateTeamView()),
                        onCreateMatch: () => Go.to(const CreateMatchTeamView()),
                      ),
                    ),
                    SizedBox(height: 22.h),
                    _SectionHeader(
                      title: LocaleKeys.stadiumsAvailableSports,
                      onViewAll: () => Go.to(const StadiumSportsView()),
                    ),
                    SizedBox(height: 12.h),
                    BlocBuilder<SportsCubit, AsyncState<List<SportCategory>?>>(
                      builder: (context, state) {
                        if (state.isError) {
                          return SizedBox(
                            height: 150.h,
                            child: _MainTabErrorView(
                              message: state.errorMessage,
                              onRetry: context.read<SportsCubit>().loadSports,
                            ),
                          );
                        }
                        if (state.isLoading || state.data == null) {
                          return const _SportsSectionShimmer();
                        }
                        return SportsScroller(
                          sports: state.data!,
                          onSportTap: (sport) =>
                              Go.to(StadiumSportView(sport: sport)),
                        );
                      },
                    ),
                    SizedBox(height: 22.h),
                    _SectionHeader(
                      title: LocaleKeys.stadiumsFeatured,
                      onViewAll: () => Go.to(const StadiumSearchView()),
                    ),
                    SizedBox(height: 12.h),
                    BlocBuilder<
                      StadiumsHomeCubit,
                      AsyncState<StadiumHomePayload?>
                    >(
                      builder: (context, state) {
                        if (state.isError) {
                          return SizedBox(
                            height: 240.h,
                            child: _MainTabErrorView(
                              message: state.errorMessage,
                              onRetry: context
                                  .read<StadiumsHomeCubit>()
                                  .loadHomePayload,
                            ),
                          );
                        }
                        if (state.isLoading || state.data == null) {
                          return const _StadiumsSectionShimmer();
                        }
                        return Column(
                          children: state.data!.stadiums
                              .map(
                                (stadium) => Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: StadiumCard(
                                    stadium: stadium,
                                    onDetails: () => Go.to(
                                      StadiumDetailsView(stadiumId: stadium.id),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
