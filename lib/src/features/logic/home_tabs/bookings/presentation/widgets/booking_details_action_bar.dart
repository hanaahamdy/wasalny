part of '../bookings_feature.dart';

class _BookingDetailsActionBar extends StatelessWidget {
  final BookingEntity booking;

  const _BookingDetailsActionBar({required this.booking});

  bool get _canRate => booking.status == BookingStatus.finished;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 18.h),
      child: Row(
        children: [
          const Expanded(child: _CancelOrderButton()),
          if (_canRate) ...[
            SizedBox(width: 12.w),
            const Expanded(child: _RateOrderButton()),
          ],
        ],
      ),
    );
  }
}

class _CancelOrderButton extends StatelessWidget {
  const _CancelOrderButton();

  void _showCancelReasonsSheet(BuildContext context) {
    showModalBottomSheet<CancelReasonEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => const _CancelBookingReasonsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      title: LocaleKeys.bookingsCancelBooking,
      height: 56.h,
      color: AppColors.bookingCancelRed,
      borderRadius: BorderRadius.circular(28.r),
      onTap: () => _showCancelReasonsSheet(context),
    );
  }
}

class _RateOrderButton extends StatelessWidget {
  const _RateOrderButton();

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
    return DefaultButton(
      title: LocaleKeys.bookingsRateStadium,
      height: 56.h,
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(28.r),
      onTap: () => _showRatingSheet(context),
    );
  }
}
