part of '../../bookings_feature.dart';

class _BookingInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _BookingInfoRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 13.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: valueColor ?? AppColors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: AppColors.hintText,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
