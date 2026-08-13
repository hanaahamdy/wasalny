part of '../../imports/create_match_imports.dart';

class StadiumSportBadge extends StatelessWidget {
  final String sport;

  const StadiumSportBadge({super.key, required this.sport});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.createMatchSelectionFill,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            sport,
            style: TextStyle(
              color: AppColors.bookingDetailsSportText,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 6.w),
          Icon(
            Icons.sports_soccer,
            size: 12.r,
            color: AppColors.bookingDetailsSportText,
          ),
        ],
      ),
    );
  }
}
