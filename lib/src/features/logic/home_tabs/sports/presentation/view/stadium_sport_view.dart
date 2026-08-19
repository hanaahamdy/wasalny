part of '../../../stadiums/presentation/imports/stadiums_imports.dart';

class StadiumSportView extends StatefulWidget {
  final SportCategory sport;

  const StadiumSportView({super.key, required this.sport});

  @override
  State<StadiumSportView> createState() => _StadiumSportViewState();
}

class _StadiumSportViewState extends State<StadiumSportView> {
  final TextEditingController _controller = TextEditingController();
  late final StadiumSearchCubit _cubit = StadiumSearchCubit()
    ..searchBySport(widget.sport.id);

  @override
  void dispose() {
    _cubit.close();
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    _cubit.searchBySport(widget.sport.id, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.subtleBackground,
        appBar: CustomAppbar(title: widget.sport.name),
        body: BlocBuilder<StadiumSearchCubit, AsyncState<List<Stadium>?>>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
                  sliver: SliverToBoxAdapter(
                    child: MainTabSearch(
                      controller: _controller,
                      onSearch: _search,
                    ),
                  ),
                ),
                if (state.isLoading || state.data == null)
                  const SliverFillRemaining(
                    child: Center(
                      child: LoadingIndicator(color: AppColors.primary),
                    ),
                  )
                else if (state.isError)
                  SliverFillRemaining(
                    child: _StadiumErrorView(
                      message: state.errorMessage,
                      onRetry: _search,
                    ),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 28.h),
                    sliver: SliverList.separated(
                      itemBuilder: (context, index) {
                        final stadium = state.data![index];
                        return StadiumCard(
                          stadium: stadium,
                          onDetails: () =>
                              Go.to(StadiumDetailsView(stadiumId: stadium.id)),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: state.data!.length,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
