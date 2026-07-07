part of '../imports/stadiums_imports.dart';

class StadiumDetailsView extends StatefulWidget {
  final int stadiumId;

  const StadiumDetailsView({super.key, required this.stadiumId});

  @override
  State<StadiumDetailsView> createState() => _StadiumDetailsViewState();
}

class _StadiumDetailsViewState extends State<StadiumDetailsView> {
  late final StadiumDetailsCubit _cubit = StadiumDetailsCubit()
    ..getStadium(widget.stadiumId);

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
          bottomNavigationBar:
              BlocBuilder<StadiumDetailsCubit, StadiumCubitState<Stadium>>(
                builder: (context, state) {
                  final stadium = state.data;
                  if (stadium == null) return const SizedBox.shrink();

                  return Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 18.h),
                    child: DefaultButton(
                      title: LocaleKeys.stadiumsBookField,
                      height: 56.h,
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(28.r),
                      onTap: () async {
                        Go.to(BookingSummaryView(stadium: stadium));
                      },
                    ),
                  );
                },
              ),
          body: BlocBuilder<StadiumDetailsCubit, StadiumCubitState<Stadium>>(
            builder: (context, state) {
              if (state.isLoading || state.data == null) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              if (state.isError) {
                return _StadiumErrorView(
                  message: state.errorMessage,
                  onRetry: () => context.read<StadiumDetailsCubit>().getStadium(
                    widget.stadiumId,
                  ),
                );
              }

              final stadium = state.data!;
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _DetailsHero(stadium: stadium)),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 24.h),
                    sliver: SliverList.list(
                      children: [
                        _DetailsTitle(stadium: stadium),
                        SizedBox(height: 18.h),
                        Text(
                          stadium.description,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColors.hintText,
                            fontSize: 13.sp,
                            height: 1.8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 26.h),
                        Row(
                          children: [
                            Expanded(
                              child: _InfoTile(
                                title: LocaleKeys.stadiumsHourPrice,
                                value: LocaleKeys.stadiumsRiyalAmount
                                    .replaceFirst(
                                      '{amount}',
                                      '${stadium.price}',
                                    ),
                                icon: Icons.attach_money,
                              ),
                            ),
                            SizedBox(width: 24.w),
                            Expanded(
                              child: _InfoTile(
                                title: LocaleKeys.stadiumsWorkingHours,
                                value: stadium.openHours,
                                icon: Icons.schedule,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 28.h),
                        Text(
                          LocaleKeys.stadiumsFacilitiesServices,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        _ServicesGrid(services: stadium.services),
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
