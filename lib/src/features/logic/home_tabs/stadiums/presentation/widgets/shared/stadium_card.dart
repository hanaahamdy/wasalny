part of '../../imports/stadiums_imports.dart';

class StadiumCard extends StatelessWidget {
  final Stadium stadium;
  final VoidCallback onDetails;
  final bool compact;

  const StadiumCard({
    super.key,
    required this.stadium,
    required this.onDetails,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: stadium.imageUrl,
                height: 176.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => const _ImageFallback(),
                errorWidget: (context, url, error) => const _ImageFallback(),
              ),
              PositionedDirectional(
                top: 16.h,
                end: 16.w,
                child: _RatingPill(rating: stadium.rating),
              ),
              PositionedDirectional(
                top: 16.h,
                start: 16.w,
                child: _SportPill(label: stadium.sport),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 14.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stadium.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              stadium.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.hintText,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.location_on,
                            size: 13.r,
                            color: AppColors.hintText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${stadium.price}',
                      style: TextStyle(
                        color: const Color(0xFF009A68),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      LocaleKeys.stadiumsPricePerHour,
                      style: TextStyle(
                        color: AppColors.hintText,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
          if (!compact)
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
              child: SizedBox(
                width: double.infinity,
                height: 39.h,
                child: TextButton(
                  onPressed: onDetails,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFEAFBF3),
                    foregroundColor: AppColors.bookingHeaderGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    LocaleKeys.details,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
