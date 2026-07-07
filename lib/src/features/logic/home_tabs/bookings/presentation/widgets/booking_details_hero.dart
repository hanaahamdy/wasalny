part of '../bookings_feature.dart';

class _BookingDetailsHero extends StatelessWidget {
  final BookingEntity booking;

  const _BookingDetailsHero({required this.booking});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 288.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: booking.imageUrl,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => Container(
                color: AppColors.primary,
                child: Icon(Icons.stadium, color: AppColors.white, size: 42.r),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: .30),
                    AppColors.black.withValues(alpha: .08),
                    AppColors.black.withValues(alpha: .72),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 58.h,
            right: 24.w,
            child: const _RoundBackButton(onTap: Go.back),
          ),
          Positioned(
            left: 24.w,
            right: 24.w,
            bottom: 18.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _SmallChip(
                      label: booking.status.label,
                      color: booking.status.color,
                    ),
                    SizedBox(width: 8.w),
                    _SmallChip(
                      label: booking.type,
                      color: AppColors.bookingSportGreen,
                      icon: Icons.sports_soccer,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  booking.title,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        booking.location,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: .86),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.white,
                      size: 16.r,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
