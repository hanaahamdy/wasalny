part of '../sports_feature.dart';

class SportsScroller extends StatelessWidget {
  final List<SportCategory> sports;
  final ValueChanged<SportCategory>? onSportTap;

  const SportsScroller({super.key, required this.sports, this.onSportTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sports.length,
        separatorBuilder: (context, index) => SizedBox(width: 18.w),
        itemBuilder: (context, index) {
          final sport = sports[index];
          return SizedBox(
            width: 82.w,
            child: InkWell(
              onTap: () => onSportTap?.call(sport),
              borderRadius: BorderRadius.circular(12.r),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: sport.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const _SportImageFallback(),
                        errorWidget: (context, url, error) =>
                            const _SportImageFallback(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    sport.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SportImageFallback extends StatelessWidget {
  const _SportImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary.withValues(alpha: 0.12),
      alignment: Alignment.center,
      child: Icon(Icons.sports_soccer, color: AppColors.primary, size: 30.r),
    );
  }
}
