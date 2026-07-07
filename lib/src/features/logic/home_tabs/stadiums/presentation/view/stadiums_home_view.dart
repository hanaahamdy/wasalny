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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: BlocBuilder<StadiumsHomeCubit, StadiumCubitState<StadiumHomePayload>>(
                builder: (context, state) {
                  if (state.isLoading || state.data == null) {
                    return  const Center(
                      child: LoadingIndicator(
                        color: AppColors.primary,
                      ),
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
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 24.h),
                        sliver: SliverList.list(
                          children: [
                            _QuickActionsRow(
                              onCreateTeam: () => Go.to(const TeamTabView()),
                              onCreateMatch: () =>
                                  Go.to(const StadiumSearchView()),
                            ),
                            SizedBox(height: 22.h),
                            _SectionHeader(
                              title: LocaleKeys.stadiumsAvailableSports,
                              onViewAll: () => Go.to(const StadiumSearchView()),
                            ),
                            SizedBox(height: 12.h),
                            _SportsScroller(sports: payload.sports),
                            SizedBox(height: 22.h),
                            _SectionHeader(
                              title: LocaleKeys.stadiumsFeatured,
                              onViewAll: () => Go.to(const StadiumSearchView()),
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
    );
  }
}
