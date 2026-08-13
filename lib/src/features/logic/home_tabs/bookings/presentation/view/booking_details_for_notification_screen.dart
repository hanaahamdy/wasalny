part of '../bookings_feature.dart';

class BookingDetailsForNotificationScreen extends StatelessWidget {
  final BookingEntity booking;

  const BookingDetailsForNotificationScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.subtleBackground,
        appBar: CustomAppbar(title: LocaleKeys.bookingDetailsTitle),
        bottomNavigationBar: const _NotificationBookingPayBar(),
        body: _NotificationBookingDetailsBody(booking: booking),
      ),
    );
  }
}

class _NotificationBookingDetailsBody extends StatelessWidget {
  final BookingEntity booking;

  const _NotificationBookingDetailsBody({required this.booking});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(24.w, 17.h, 24.w, 24.h),
      children: [
        _NotificationDetailRow(
          title: LocaleKeys.stadiumsBookingType,
          value: booking.type,
        ),
        SizedBox(height: 16.h),
        _NotificationDetailRow(
          title: LocaleKeys.stadiumsBookingDateTime,
          value: '${booking.date}  ${booking.time}',
        ),
        SizedBox(height: 16.h),
        _NotificationDetailRow(
          title: LocaleKeys.stadiumsPrice,
          value: LocaleKeys.stadiumsRiyalAmount(amount: '${booking.total}'),
        ),
        SizedBox(height: 16.h),
        _NotificationDetailRow(
          title: LocaleKeys.stadiumsPaymentMethod,
          value: booking.paymentMethod,
        ),
        SizedBox(height: 16.h),
        const _NotificationBookingTermsCard(),
        SizedBox(height: 17.h),
        _NotificationBookingVenueCard(booking: booking),
      ],
    );
  }
}

class _NotificationDetailRow extends StatelessWidget {
  final String title;
  final String value;

  const _NotificationDetailRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .02),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              textDirection: TextDirection.rtl,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.notificationText,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationBookingTermsCard extends StatelessWidget {
  const _NotificationBookingTermsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(22.w, 22.h, 22.w, 26.h),
      decoration: BoxDecoration(
        color: AppColors.bookingDetailsTermsBackground,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                LocaleKeys.bookingDetailsConditions,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 10.w),
              Icon(Icons.shield_outlined, color: AppColors.primary, size: 20.r),
            ],
          ),
          SizedBox(height: 23.h),
          Text(
            LocaleKeys.bookingDetailsUnpaidWarning,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: AppColors.notificationText,
              fontSize: 14.sp,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationBookingVenueCard extends StatelessWidget {
  final BookingEntity booking;

  const _NotificationBookingVenueCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.bookingDetailsCardBorder),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 176.h,
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
                        size: 36.r,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: _SmallChip(
                    label: booking.type,
                    color: AppColors.bookingDetailsSportBackground,
                    textColor: AppColors.bookingDetailsSportText,
                    icon: Icons.sports_soccer,
                  ),
                ),
                Positioned(
                  top: 16.h,
                  left: 16.w,
                  child: const _RatingChip(rating: '4.8'),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  booking.title,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        booking.location,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.hintText,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(
                      Icons.location_on,
                      color: AppColors.notificationText,
                      size: 14.r,
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

class _RatingChip extends StatelessWidget {
  final String rating;

  const _RatingChip({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: .45),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: AppColors.ratingStar, size: 13.r),
          SizedBox(width: 5.w),
          Text(
            rating,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationBookingPayBar extends StatelessWidget {
  const _NotificationBookingPayBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 18.h),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.bookingDetailsBottomShadow,
            blurRadius: 18,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: DefaultButton(
        title: LocaleKeys.pay,
        height: 56.h,
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(28.r),
        fontSize: 16.sp,
        fontWeight: FontWeight.w800,
        onTap: () {},
      ),
    );
  }
}
