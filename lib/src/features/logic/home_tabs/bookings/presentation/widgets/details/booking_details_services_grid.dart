part of '../../bookings_feature.dart';

class _BookingServicesGrid extends StatelessWidget {
  final BookingEntity booking;

  const _BookingServicesGrid({required this.booking});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        Icons.calendar_today_outlined,
        LocaleKeys.bookingsDate,
        booking.date,
        AppColors.bookingServiceGreen,
      ),
      (
        Icons.access_time_rounded,
        LocaleKeys.bookingsTime,
        booking.time,
        AppColors.primary,
      ),
      (
        Icons.timer_outlined,
        LocaleKeys.bookingsDuration,
        booking.duration,
        AppColors.bookingRatingOrange,
      ),
    ];
    return Row(
      children: List.generate(items.length, (index) {
        final item = items[index];
        return Expanded(
          child: Container(
            height: 100.h,
            margin: EdgeInsetsDirectional.only(
              end: index == items.length - 1 ? 0 : 10.w,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: .04),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 28.r,
                  height: 28.r,
                  decoration: BoxDecoration(
                    color: item.$4.withValues(alpha: .12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.$1, color: item.$4, size: 15.r),
                ),
                SizedBox(height: 7.h),
                Text(
                  item.$2,
                  style: TextStyle(
                    color: AppColors.hintText,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  item.$3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
