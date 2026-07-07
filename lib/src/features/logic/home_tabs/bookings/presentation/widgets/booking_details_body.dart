part of '../bookings_feature.dart';

class _BookingDetailsBody extends StatelessWidget {
  final BookingEntity booking;

  const _BookingDetailsBody({required this.booking});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _BookingDetailsHero(booking: booking)),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 28.h),
          sliver: SliverList.list(
            children: [
              _BookingCodeCard(code: booking.code),
              SizedBox(height: 14.h),
              _BookingServicesGrid(services: booking.services),
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
