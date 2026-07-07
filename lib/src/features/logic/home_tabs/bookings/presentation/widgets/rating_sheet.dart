part of '../bookings_feature.dart';

class _RatingSheet extends StatefulWidget {
  const _RatingSheet();

  @override
  State<_RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<_RatingSheet> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          24.w,
          8.h,
          24.w,
          MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.sheetHandle,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 26.h),
            Icon(
              Icons.workspace_premium,
              color: AppColors.successGreen,
              size: 48.r,
            ),
            SizedBox(height: 18.h),
            Text(
              LocaleKeys.bookingsRateStadium,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 22.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final star = index + 1;
                return IconButton(
                  onPressed: () => setState(() => _rating = star),
                  icon: Icon(
                    star <= _rating ? Icons.star : Icons.star_border,
                    color: AppColors.ratingStar,
                    size: 30.r,
                  ),
                );
              }),
            ),
            SizedBox(height: 14.h),
            TextField(
              maxLines: 4,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: LocaleKeys.bookingsRatingHint,
                hintStyle: TextStyle(
                  color: AppColors.secondaryHintText,
                  fontSize: 12.sp,
                ),
                filled: true,
                fillColor: AppColors.subtleBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            DefaultButton(
              title: LocaleKeys.bookingsSubmitRating,
              height: 56.h,
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(28.r),
              onTap: Go.back,
            ),
          ],
        ),
      ),
    );
  }
}
