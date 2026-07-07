part of '../bookings_feature.dart';

class _BookingDetailsActionBar extends StatelessWidget {
  final BookingEntity booking;

  const _BookingDetailsActionBar({required this.booking});

  bool get _canRate => booking.status == BookingStatus.finished;

  void _showRatingSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => const _RatingSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 18.h),
      child: DefaultButton(
        title: _canRate
            ? LocaleKeys.bookingsRateStadium
            : LocaleKeys.bookingsCancelBooking,
        height: 56.h,
        color: _canRate ? AppColors.primary : AppColors.bookingCancelRed,
        borderRadius: BorderRadius.circular(28.r),
        onTap: _canRate ? () => _showRatingSheet(context) : () {},
      ),
    );
  }
}
