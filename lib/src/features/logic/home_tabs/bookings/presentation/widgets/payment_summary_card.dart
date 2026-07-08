part of '../bookings_feature.dart';

class _PaymentSummaryCard extends StatelessWidget {
  final BookingEntity booking;

  const _PaymentSummaryCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return _DetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            LocaleKeys.bookingsPaymentSummary,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 16.h),
          _BookingInfoRow(
            label: LocaleKeys.stadiumsHourPrice,
            value: LocaleKeys.bookingsPoundsAmount(
              amount: '${booking.hourPrice}',
            ),
          ),
          _BookingInfoRow(
            label: LocaleKeys.bookingsHoursCount,
            value: booking.duration,
          ),
          _BookingInfoRow(
            label: LocaleKeys.bookingsTotal,
            value: LocaleKeys.bookingsPoundsAmount(amount: '${booking.total}'),
            valueColor: AppColors.bookingSuccessGreen,
          ),
          Divider(height: 26.h, color: AppColors.bookingDivider),
          Row(
            children: [
              _SmallChip(
                label: booking.isPaid
                    ? LocaleKeys.bookingsPaid
                    : LocaleKeys.bookingsUnpaid,
                color: booking.isPaid
                    ? AppColors.bookingSuccessGreen
                    : AppColors.bookingPendingYellow,
                icon: booking.isPaid ? Icons.check_circle : Icons.schedule,
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  booking.paymentMethod,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.account_balance_wallet_outlined, size: 18.r),
            ],
          ),
        ],
      ),
    );
  }
}
