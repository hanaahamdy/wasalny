part of '../../bookings_feature.dart';

class _BookingPlayerCard extends StatelessWidget {
  final BookingPlayerEntity player;
  final int number;

  const _BookingPlayerCard({required this.player, required this.number});

  @override
  Widget build(BuildContext context) {
    final statusColor = player.isPaid
        ? AppColors.bookingSuccessGreen
        : AppColors.bookingDangerRed;
    return Container(
      height: 62.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 21.r,
                backgroundColor: AppColors.avatarBackground,
                backgroundImage: player.imageUrl.isNotEmpty
                    ? CachedNetworkImageProvider(player.imageUrl)
                    : null,
                child: player.imageUrl.isEmpty
                    ? Icon(
                        Icons.person,
                        color: AppColors.avatarIcon,
                        size: 24.r,
                      )
                    : null,
              ),
              PositionedDirectional(
                bottom: -2.h,
                end: -3.w,
                child: CircleAvatar(
                  radius: 8.r,
                  backgroundColor: AppColors.bookingSuccessGreen,
                  child: Text(
                    '$number',
                    style: TextStyle(color: AppColors.white, fontSize: 8.sp),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              player.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '${player.paymentStatusLabel} ${player.shareAmount} ${player.currency}',
              style: TextStyle(
                color: statusColor,
                fontSize: 9.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
