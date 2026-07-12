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
          body: BlocBuilder<BookingsCubit, BookingsState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _BookingHeader(
                      title: LocaleKeys.bookingsBookFieldTitle,
                      child: _BookingFilterTabs(
                        selectedStatus: state.selectedStatus,
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

  Widget _buildBookingsSliver(BookingsState state) {
    return switch ((state.isLoading, state.errorMessage)) {
      (true, _) => const SliverFillRemaining(
        child: Center(child: LoadingIndicator(color: AppColors.primary)),
      ),
      (_, final message?) => SliverFillRemaining(
        child: Center(child: Text(message)),
      ),
      _ => SliverPadding(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 26.h),
        sliver: SliverList.separated(
          itemCount: state.filteredBookings.length,
          separatorBuilder: (_, _) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final booking = state.filteredBookings[index];
            return _BookingCard(
              booking: booking,
              onTap: () => Go.to(BookingDetailsView(booking: booking)),
            );
          },
        ),
      ),
    };
  }
}
