part of '../wallet_feature.dart';

class _WalletSmallChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color? textColor;
  final IconData? icon;

  const _WalletSmallChip({
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
          if (icon != null) ...[
            SizedBox(width: 5.w),
            Icon(icon, color: textColor ?? AppColors.white, size: 12.r),
          ],
        ],
      ),
    );
  }
}
