part of '../imports/presentation_imports.dart';

class NotificationIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const NotificationIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppCircular.r8),
      child: Container(
        width: AppSize.sW28,
        height: AppSize.sW28,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: .22),
          borderRadius: BorderRadius.circular(AppCircular.r8),
        ),
        child: Icon(icon, color: color, size: AppSize.sH18),
      ),
    );
  }
}
