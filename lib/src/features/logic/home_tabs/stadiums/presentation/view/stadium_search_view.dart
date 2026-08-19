part of '../imports/stadiums_imports.dart';

class StadiumSearchView extends StatefulWidget {
  const StadiumSearchView({super.key});

  @override
  State<StadiumSearchView> createState() => _StadiumSearchViewState();
}

class _StadiumSearchViewState extends State<StadiumSearchView> {
  final TextEditingController _controller = TextEditingController();
  late final StadiumSearchCubit _cubit = StadiumSearchCubit()..search();

  @override
  void dispose() {
    _cubit.close();
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    _cubit.search(_controller.text);
  }

  Future<void> _openFilters() async {
    final filters = await StadiumFilterSheet.show(
      context,
      initialFilters: _cubit.filters,
    );
    if (filters == null) return;
    await _cubit.applyFilters(filters, _controller.text);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppbar(
            title: LocaleKeys.stadiumsFeatured,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Center(
                  child: InkWell(
                    onTap: _openFilters,
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        color: AppColors.stadiumFilterIconBackground,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.stadiumFilterIconBorder,
                        ),
                      ),
                      child: Icon(
                        Icons.tune,
                        color: AppColors.white,
                        size: 20.r,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
                child: MainTabSearch(
                  controller: _controller,
                  onSearch: _search,
                ),
              ),
              Expanded(
                child:
                    BlocBuilder<StadiumSearchCubit, AsyncState<List<Stadium>?>>(
                      builder: (context, state) {
                        if (state.isLoading || state.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        }

                        if (state.isError) {
                          return _StadiumErrorView(
                            message: state.errorMessage,
                            onRetry: _search,
                          );
                        }

                        final stadiums = state.data!;
                        if (stadiums.isEmpty) {
                          return const NotContainData();
                        }

                        return ListView.separated(
                          padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 28.h),
                          itemBuilder: (context, index) {
                            final stadium = stadiums[index];
                            return StadiumCard(
                              stadium: stadium,
                              onDetails: () => Go.to(
                                StadiumDetailsView(stadiumId: stadium.id),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemCount: stadiums.length,
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
