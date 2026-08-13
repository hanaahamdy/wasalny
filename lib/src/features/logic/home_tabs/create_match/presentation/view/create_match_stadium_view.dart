part of '../imports/create_match_imports.dart';

class CreateMatchStadiumView extends StatefulWidget {
  final CreateMatchTeam team;

  const CreateMatchStadiumView({super.key, required this.team});

  @override
  State<CreateMatchStadiumView> createState() => _CreateMatchStadiumViewState();
}

class _CreateMatchStadiumViewState extends State<CreateMatchStadiumView> {
  final ValueNotifier<int?> _selectedStadiumIdNotifier = ValueNotifier(null);
  late final CreateMatchStadiumsCubit _stadiumsCubit =
      CreateMatchStadiumsCubit()..fetchStadiums();
  late final ScrollController _scrollController = ScrollController()
    ..addListener(_onScroll);
  List<CreateMatchStadium> _stadiums = const [];

  void _onScroll() {
    if (_scrollController.position.extentAfter < 250) {
      _stadiumsCubit.fetchMoreStadiums();
    }
  }

  Future<void> _continueWithSelectedStadium() async {
    final selectedStadium = _stadiums.firstWhere(
      (stadium) => stadium.id == _selectedStadiumIdNotifier.value,
    );
    await Go.to(
      CreateMatchDateTimeView(team: widget.team, stadium: selectedStadium),
    );
  }

  @override
  void dispose() {
    _selectedStadiumIdNotifier.dispose();
    _scrollController.dispose();
    _stadiumsCubit.close();
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
        value: _stadiumsCubit,
        child: Scaffold(
          appBar: CustomAppbar(title: LocaleKeys.stadiumsCreateMatch),
          backgroundColor: AppColors.scaffoldBackground,
          body: Column(
            children: [
              Expanded(
                child:
                    BlocBuilder<
                      CreateMatchStadiumsCubit,
                      AsyncState<List<CreateMatchStadium>>
                    >(
                      builder: (context, stadiumsState) {
                        if (stadiumsState.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        }
                        if (stadiumsState.isError) {
                          return Center(
                            child: TextButton(
                              onPressed: _stadiumsCubit.fetchStadiums,
                              child: Text(LocaleKeys.stadiumsRetry),
                            ),
                          );
                        }
                        _stadiums = stadiumsState.data;
                        return ValueListenableBuilder<int?>(
                          valueListenable: _selectedStadiumIdNotifier,
                          builder: (context, selectedStadiumId, _) => ListView(
                            controller: _scrollController,
                            padding: EdgeInsets.fromLTRB(
                              24.w,
                              20.h,
                              24.w,
                              24.h,
                            ),
                            children: [
                              Text(
                                LocaleKeys.createMatchChooseStadium,
                                style: TextStyle(
                                  color: AppColors.notificationText,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              ..._stadiums.map(
                                (stadium) => Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: CreateMatchStadiumCard(
                                    stadium: stadium,
                                    isSelected: selectedStadiumId == stadium.id,
                                    onTap: () =>
                                        _selectedStadiumIdNotifier.value =
                                            stadium.id,
                                  ),
                                ),
                              ),
                              if (stadiumsState.isLoadingMore)
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
              ),
              ValueListenableBuilder<int?>(
                valueListenable: _selectedStadiumIdNotifier,
                builder: (context, selectedStadiumId, _) {
                  return CreateMatchBottomAction(
                    enabled: selectedStadiumId != null,
                    onNext: _continueWithSelectedStadium,
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
