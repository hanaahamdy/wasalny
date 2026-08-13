part of '../bookings_feature.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  late final BookingsCubit _cubit = BookingsCubit()..loadBookings();

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
          backgroundColor: AppColors.subtleBackground,
          body: BlocBuilder<BookingsCubit, AsyncState<List<BookingEntity>>>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _BookingHeader(
                      title: LocaleKeys.bookings,
                      child: _BookingFilterTabs(
                        selectedStatus: _cubit.selectedStatus,
                        onChanged: context.read<BookingsCubit>().selectStatus,
                      ),
                    ),
                  ),
                  _buildBookingsSliver(state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBookingsSliver(AsyncState<List<BookingEntity>> state) {
    final bookings = _cubit.filteredBookings;
    return switch ((state.isLoading, state.errorMessage)) {
      (true, _) => const SliverFillRemaining(
        child: Center(child: LoadingIndicator(color: AppColors.primary)),
      ),
      (_, final message?) => SliverFillRemaining(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message, textAlign: TextAlign.center),
                SizedBox(height: 16.h),
                DefaultButton(
                  title: LocaleKeys.stadiumsRetry,
                  width: 140.w,
                  onTap: _cubit.loadBookings,
                ),
              ],
            ),
          ),
        ),
      ),
      _ when bookings.isEmpty => SliverFillRemaining(
        child: Center(child: Text(LocaleKeys.noDataFound)),
      ),
      _ => SliverPadding(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 26.h),
        sliver: SliverList.separated(
          itemCount: bookings.length,
          separatorBuilder: (_, _) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return _BookingCard(
              booking: booking,
              onTap: () async {
                final wasCancelled = await Go.to<bool>(
                  BookingDetailsView(booking: booking),
                );
                if (wasCancelled == true) {
                  _cubit.loadBookings();
                }
              },
            );
          },
        ),
      ),
    };
  }
}
