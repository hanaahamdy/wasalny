part of '../imports/stadiums_imports.dart';

class StadiumsHomeView extends StatefulWidget {
  const StadiumsHomeView({super.key});

  @override
  State<StadiumsHomeView> createState() => _StadiumsHomeViewState();
}

class _StadiumsHomeViewState extends State<StadiumsHomeView> {
  late final StadiumsHomeCubit _cubit = StadiumsHomeCubit()..loadHomePayload();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.scaffoldBackground,
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child:
                BlocBuilder<
                  StadiumsHomeCubit,
                  StadiumCubitState<StadiumHomePayload>
                >(
                  builder: (context, state) {
                    if (state.isLoading || state.data == null) {
                      return const Center(
                        child: LoadingIndicator(color: AppColors.primary),
                      );
                    }
                    if (state.isError) {
                      return _StadiumErrorView(
                        message: state.errorMessage,
                        onRetry: context
                            .read<StadiumsHomeCubit>()
                            .loadHomePayload,
                      );
                    }

                    final payload = state.data!;
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: _HomeHero(
                            onSearchTap: () => Go.to(const StadiumSearchView()),
                            onNotificationTap: () =>
                                Go.to(const NotificationScreen()),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 24.h),
                          sliver: SliverList.list(
                            children: [
                              _QuickActionsRow(
                                onCreateTeam: () =>
                                    Go.to(const CreateTeamView()),
                                onCreateMatch: () =>
                                    Go.to(const StadiumSearchView()),
                              ),
                              SizedBox(height: 22.h),
                              _SectionHeader(
                                title: LocaleKeys.stadiumsAvailableSports,
                                onViewAll: () => Go.to(
                                  StadiumSportsView(sports: payload.sports),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              _SportsScroller(
                                sports: payload.sports,
                                onSportTap: (sport) =>
                                    Go.to(StadiumSportView(sport: sport)),
                              ),
                              SizedBox(height: 22.h),
                              _SectionHeader(
                                title: LocaleKeys.stadiumsFeatured,
                                onViewAll: () =>
                                    Go.to(const StadiumSearchView()),
                              ),
                              SizedBox(height: 12.h),
                              ...payload.stadiums.map(
                                (stadium) => Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: StadiumCard(
                                    stadium: stadium,
                                    onDetails: () => Go.to(
                                      StadiumDetailsView(stadiumId: stadium.id),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
          ),
        ),
      ),
    );
  }
}
