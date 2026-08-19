part of '../../bookings_feature.dart';

class _BookingCard extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback onTap;

  const _BookingCard({required this.booking, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: .06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 128.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: booking.imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => Container(
                        color: AppColors.bookingImageFallback,
                        child: Icon(
                          Icons.stadium,
                          color: AppColors.bookingPrimaryGreen,
                          size: 32.r,
                        ),
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
                            AppColors.black.withValues(alpha: .16),
                            AppColors.black.withValues(alpha: .60),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16.h,
                    right: 16.w,
                    child: _SmallChip(
                      label: booking.status.label,
                      color: booking.status.color,
                    ),
                  ),
                  Positioned(
                    top: 16.h,
                    left: 16.w,
                    child: _SmallChip(
                      label: booking.type,
                      color: AppColors.bookingSportGreen,
                      icon: Icons.sports_soccer,
                    ),
                  ),
                  Positioned(
                    right: 16.w,
                    bottom: 14.h,
                    child: Text(
                      booking.title,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          booking.location,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.hintText,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.bookingPrimaryGreen,
                        size: 16.r,
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      _IconText(
                        icon: Icons.calendar_month_outlined,
                        label: booking.date,
                      ),

                      SizedBox(width: 18.w),
                      _IconText(icon: Icons.schedule, label: booking.time),
                      const Spacer(),
                      _PriceBlock(booking: booking),
                    ],
                  ),
                  if (booking.isMatch) ...[
                    SizedBox(height: 14.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(booking.homeTeam!, style: _teamStyle(context)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Text(
                            LocaleKeys.bookingsVersus,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(booking.awayTeam!, style: _teamStyle(context)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _teamStyle(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
    );
  }
}

class _SmallChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color? textColor;
  final IconData? icon;

  const _SmallChip({
    required this.label,
    required this.color,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor ?? AppColors.white, size: 12.r),
            SizedBox(width: 5.w),
          ],
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor ?? AppColors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 6.w),
        Icon(icon, color: AppColors.bookingPrimaryGreen, size: 16.r),
      ],
    );
  }
}

class _PriceBlock extends StatelessWidget {
  final BookingEntity booking;

  const _PriceBlock({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${booking.total} ${booking.currency}',
          style: TextStyle(
            color: AppColors.bookingPriceGreen,
            fontSize: 17.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          booking.duration,
          style: TextStyle(
            color: AppColors.hintText,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
