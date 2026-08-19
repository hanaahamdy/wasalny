part of '../../bookings_feature.dart';

class _BookingDetailsBody extends StatelessWidget {
  final BookingEntity booking;

  const _BookingDetailsBody({required this.booking});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _BookingDetailsHero(booking: booking)),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 22.h),
          sliver: SliverList.list(
            children: [
              _BookingServicesGrid(booking: booking),
              SizedBox(height: 14.h),
              _PaymentSummaryCard(booking: booking),
              SizedBox(height: 14.h),
              _BookedAtCard(bookedAt: booking.bookedAt),
            ],
          ),
        ),
      ],
    );
  }
}
