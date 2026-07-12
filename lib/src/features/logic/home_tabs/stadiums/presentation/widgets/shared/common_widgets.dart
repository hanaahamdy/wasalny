part of '../../imports/stadiums_imports.dart';

class _RatingPill extends StatelessWidget {
  final double rating;
  final bool darkText;

  const _RatingPill({required this.rating, this.darkText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      padding: EdgeInsets.symmetric(horizontal: 11.w),
      decoration: BoxDecoration(
        color: darkText
            ? const Color(0xFFFFF8E8)
            : const Color(0xFF284A59).withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              color: darkText ? AppColors.black : AppColors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(Icons.star, color: const Color(0xFFFFC529), size: 14.r),
        ],
      ),
    );
  }
}

class _SportPill extends StatelessWidget {
  final String label;

  const _SportPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      padding: EdgeInsets.symmetric(horizontal: 11.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE9FFF6),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF02A66D),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 6.w),
          Icon(Icons.sports_soccer, color: const Color(0xFF02A66D), size: 13.r),
        ],
      ),
    );
  }
}

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

class _Dot extends StatelessWidget {
  final bool active;

  const _Dot({required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: active ? 20.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: active ? 1 : 0.62),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF39B87F), Color(0xFF2B3289)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Center(
        child: Icon(Icons.stadium, color: AppColors.white, size: 34.r),
      ),
    );
  }
}

class _StadiumErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;

  const _StadiumErrorView({required this.message, required this.onRetry});

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
