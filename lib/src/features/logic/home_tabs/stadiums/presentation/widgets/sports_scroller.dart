part of '../imports/stadiums_imports.dart';

class _SportsScroller extends StatelessWidget {
  final List<SportCategory> sports;

  const _SportsScroller({required this.sports});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: sports.length,
        separatorBuilder: (context, index) => SizedBox(width: 18.w),
        itemBuilder: (context, index) => SizedBox(
          width: 82.w,
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: sports[index].imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const _ImageFallback(),
                    errorWidget: (context, url, error) =>
                        const _ImageFallback(),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                sports[index].name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
