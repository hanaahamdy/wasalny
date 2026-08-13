part of '../bookings_feature.dart';

class BookingDetailsView extends StatelessWidget {
  final BookingEntity booking;

  const BookingDetailsView({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (_) =>
            BookingDetailsCubit(initialBooking: booking)..fetchDetails(),
        child: BlocBuilder<BookingDetailsCubit, AsyncState<BookingEntity?>>(
          builder: (context, state) {
            final details = state.data ?? booking;
            return Scaffold(
              backgroundColor: AppColors.subtleBackground,
              bottomNavigationBar: state.status.isLoading
                  ? null
                  : _BookingDetailsActionBar(booking: details),
              body: state.status.isLoading
                  ? CustomLoading.showLoadingView()
                  : state.status.isError
                  ? Center(
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
                                  .read<BookingDetailsCubit>()
                                  .fetchDetails,
                            ),
                          ],
                        ),
                      ),
                    )
                  : _BookingDetailsBody(booking: details),
            );
          },
        ),
      ),
    );
  }
}
