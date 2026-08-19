part of '../../bookings_feature.dart';

class _BookedAtCard extends StatelessWidget {
  final String bookedAt;

  const _BookedAtCard({required this.bookedAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.access_time_rounded,
            color: AppColors.hintText,
            size: 14.r,
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              '${LocaleKeys.bookingsBookedAt}: $bookedAt',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.hintText,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
