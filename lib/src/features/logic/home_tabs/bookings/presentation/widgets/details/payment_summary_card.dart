part of '../../bookings_feature.dart';

class _PaymentSummaryCard extends StatelessWidget {
  final BookingEntity booking;

  const _PaymentSummaryCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return _DetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            value: '${booking.hourPrice} ${booking.currency}',
          ),
          _BookingInfoRow(
            label: LocaleKeys.bookingsHoursCount,
            value: booking.duration,
          ),
          _BookingInfoRow(
            label: LocaleKeys.bookingsAdditionalCost,
            value: '${booking.additionalCost} ${booking.currency}',
          ),
          Divider(height: 20.h, color: AppColors.bookingDivider),
          _BookingInfoRow(
            label: LocaleKeys.bookingsTotal,
            value: '${booking.total} ${booking.currency}',
            valueColor: AppColors.bookingSuccessGreen,
          ),
          Divider(height: 20.h, color: AppColors.bookingDivider),
          Row(
            children: [
              Expanded(
                child: _PaymentDetail(
                  label: LocaleKeys.bookingsPaymentMethod,
                  value: booking.paymentMethod,
                  icon: Icons.account_balance_wallet_outlined,
                  color: AppColors.black,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _PaymentDetail(
                  label: LocaleKeys.bookingsPaymentStatus,
                  value: booking.paymentStatus.isNotEmpty
                      ? booking.paymentStatus
                      : booking.isPaid
                      ? LocaleKeys.bookingsPaid
                      : LocaleKeys.bookingsUnpaid,
                  icon: booking.isPaid
                      ? Icons.check_circle_outline
                      : Icons.info_outline,
                  color: booking.isPaid
                      ? AppColors.bookingSuccessGreen
                      : AppColors.bookingDangerRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentDetail extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _PaymentDetail({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.bookingMutedText,
            fontSize: 9.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Icon(icon, size: 16.r, color: color),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
