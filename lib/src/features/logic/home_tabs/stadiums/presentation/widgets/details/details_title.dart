part of '../../imports/stadiums_imports.dart';

class _DetailsTitle extends StatelessWidget {
  final Stadium stadium;

  const _DetailsTitle({required this.stadium});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      stadium.location,
                      style: TextStyle(
                        color: AppColors.hintText,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Icon(
                    Icons.location_on,
                    size: 16.r,
                    color: AppColors.stadiumSectionAction,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                stadium.name,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        _RatingPill(rating: stadium.rating, darkText: true),
      ],
    );
  }
}
