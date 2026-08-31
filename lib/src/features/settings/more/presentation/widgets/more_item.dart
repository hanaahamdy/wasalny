part of '../more_screen.dart';

class _MoreItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isDestructive;

  const _MoreItem({
    required this.title,
    required this.icon,
    this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.main;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppCircular.r12),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW12,
          vertical: AppPadding.pH10,
        ),
        child: Row(
          children: [
            Container(
              width: AppSize.sW30,
              height: AppSize.sW30,
              decoration: BoxDecoration(
                color: isDestructive
                    ? AppColors.error.withValues(alpha: .1)
                    : AppColors.moreIconBackground,
                borderRadius: BorderRadius.circular(AppCircular.r8),
              ),
              child: Icon(icon, color: color, size: AppSize.sH18),
            ),
            SizedBox(width: AppSize.sW12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: FontSizeManager.s12,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ),
            Icon(
              isRtl ? Icons.chevron_left : Icons.chevron_right,
              color: isDestructive ? AppColors.error : AppColors.grey2,
              size: AppSize.sH16,
            ),
          ],
        ),
      ),
    );
  }
}
