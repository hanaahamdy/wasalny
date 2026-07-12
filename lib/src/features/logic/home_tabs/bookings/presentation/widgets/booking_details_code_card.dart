part of '../bookings_feature.dart';

class _BookingCodeCard extends StatelessWidget {
  final String code;

  const _BookingCodeCard({required this.code});

  @override
  Widget build(BuildContext context) {
    return _DetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.orderNumber,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16,horizontal: AppPadding.pW10),
            decoration: BoxDecoration(
              color: AppColors.bookingCodeBackground,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              code,
              style: TextStyle(
                color: AppColors.bookingCodeText,
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
