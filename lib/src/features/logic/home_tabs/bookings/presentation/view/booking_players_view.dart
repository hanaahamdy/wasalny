part of '../bookings_feature.dart';

class BookingPlayersView extends StatelessWidget {
  final int bookingId;

  const BookingPlayersView({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (_) =>
            BookingPlayersCubit(bookingId: bookingId)..fetchPlayers(),
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppbar(title: LocaleKeys.bookingsTeamMembers),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: DefaultButton(
              title: LocaleKeys.bookingsTeamMembers,
              height: 52.h,
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(28.r),
              onTap: Go.back,
            ),
          ),
          body:
              BlocBuilder<
                BookingPlayersCubit,
                AsyncState<List<BookingPlayerEntity>>
              >(
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return CustomLoading.showLoadingView();
                  }
                  if (state.status.isError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.errorMessage ?? '',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            DefaultButton(
                              title: LocaleKeys.stadiumsRetry,
                              width: 140.w,
                              onTap: context
                                  .read<BookingPlayersCubit>()
                                  .fetchPlayers,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state.data.isEmpty) {
                    return Center(child: Text(LocaleKeys.teamNoMembers));
                  }
                  return ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
                    itemCount: state.data.length,
                    separatorBuilder: (_, _) => SizedBox(height: 12.h),
                    itemBuilder: (_, index) => _BookingPlayerCard(
                      player: state.data[index],
                      number: index + 1,
                    ),
                  );
                },
              ),
        ),
      ),
    );
  }
}
