part of '../bookings_feature.dart';

class _BookingServicesGrid extends StatelessWidget {
  final List<String> services;

  const _BookingServicesGrid({required this.services});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: services
          .map(
            (service) => Expanded(
              child: Container(
                height: 92.h,
                margin: EdgeInsetsDirectional.only(
                  end: service == services.last ? 0 : 10.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: .05),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: AppColors.bookingServiceGreen,
                      size: 24.r,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      service,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.hintText,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      bookingServiceDateLabel,
                      style: TextStyle(
                        color: AppColors.bookingMutedText,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  String get bookingServiceDateLabel => LocaleKeys.bookingsSampleDate;
}
