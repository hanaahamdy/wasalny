part of '../imports/main_tab_screen_imports.dart';

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.22),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white.withValues(alpha: 0.42)),
      ),
      child: Icon(icon, color: AppColors.white, size: 21.r),
    ).onClick(onTap: onTap);
  }
}

class _MainTabErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;

  const _MainTabErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: AppColors.error, size: 40.r),
            SizedBox(height: 12.h),
            Text(
              message ?? LocaleKeys.exceptionError,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.hintText,
                fontSize: 13.sp,
                height: 1.6,
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: 130.w,
              height: 42.h,
              child: DefaultButton(
                title: LocaleKeys.stadiumsRetry,
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(22.r),
                onTap: () async => onRetry(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
