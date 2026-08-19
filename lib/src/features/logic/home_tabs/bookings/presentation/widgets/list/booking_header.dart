part of '../../bookings_feature.dart';

class _BookingHeader extends StatelessWidget {
  final String title;
  final Widget? child;

  const _BookingHeader({required this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 58.h, 16.w, 14.h),
      decoration: const BoxDecoration(
        color: AppColors.bookingHeaderGreen,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (child != null) ...[SizedBox(height: 22.h), child!],
        ],
      ),
    );
  }
}
