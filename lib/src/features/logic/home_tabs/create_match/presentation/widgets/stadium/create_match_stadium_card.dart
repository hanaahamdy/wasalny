part of '../../imports/create_match_imports.dart';

class CreateMatchStadiumCard extends StatelessWidget {
  final CreateMatchStadium stadium;
  final bool isSelected;
  final VoidCallback onTap;

  const CreateMatchStadiumCard({
    super.key,
    required this.stadium,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Ink(
        height: 252.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: isSelected
              ? Border.all(color: AppColors.createMatchHeader)
              : null,
          boxShadow: const [
            BoxShadow(color: AppColors.createMatchCardShadow, blurRadius: 54),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 176.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24.r),
                      ),
                      child: Image.asset(
                        'assets/images/create_match_stadium.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 16.h,
                    start: 16.w,
                    child: StadiumSportBadge(sport: stadium.sport),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    _StadiumDetails(stadium: stadium),
                    const Spacer(),
                    _StadiumPrice(price: stadium.price),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StadiumPrice extends StatelessWidget {
  final int price;

  const _StadiumPrice({required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$price',
          style: TextStyle(
            color: AppColors.bookingDetailsSportText,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          LocaleKeys.stadiumsPricePerHour,
          style: TextStyle(color: AppColors.notificationText, fontSize: 12.sp),
        ),
      ],
    );
  }
}

class _StadiumDetails extends StatelessWidget {
  final CreateMatchStadium stadium;

  const _StadiumDetails({required this.stadium});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          stadium.name,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              stadium.location,
              style: TextStyle(
                color: AppColors.notificationText,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.location_on,
              size: 13.r,
              color: AppColors.notificationText,
            ),
          ],
        ),
      ],
    );
  }
}
