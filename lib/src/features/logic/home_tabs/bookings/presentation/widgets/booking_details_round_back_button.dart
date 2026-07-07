part of '../bookings_feature.dart';

class _RoundBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _RoundBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: .28),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white.withValues(alpha: .35)),
        ),
        child: Icon(Icons.arrow_forward, color: AppColors.white, size: 20.r),
      ),
    );
  }
}
