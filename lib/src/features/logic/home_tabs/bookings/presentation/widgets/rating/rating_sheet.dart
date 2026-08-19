part of '../../bookings_feature.dart';

class _RatingSheet extends StatefulWidget {
  const _RatingSheet();

  @override
  State<_RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<_RatingSheet> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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
                color: AppColors.bookingRatingSheetHandle,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(height: 24.h),
            _buildHeader(),
            SizedBox(height: 24.h),
            _buildRatingRow(),
            SizedBox(height: 12.h),
            _buildCommentField(),
            SizedBox(height: 24.h),
            BlocConsumer<RateBookingCubit, AsyncState<String?>>(
              listener: (context, state) {
                if (state.status.isSuccess) {
                  MessageUtils.showSnackBar(
                    context: context,
                    baseStatus: BaseStatus.success,
                    message: state.data?.isNotEmpty == true
                        ? state.data!
                        : LocaleKeys.dataUpdatedSuccessfully,
                  );
                  Go.back(true);
                } else if (state.status.isError) {
                  MessageUtils.showSnackBar(
                    context: context,
                    baseStatus: BaseStatus.error,
                    message: state.errorMessage ?? LocaleKeys.exceptionError,
                  );
                }
              },
              builder: (context, state) => DefaultButton(
                title: LocaleKeys.bookingsSubmitRating,
                height: 56.h,
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(28.r),
                onTap: _rating == 0 || state.status.isLoading
                    ? null
                    : () => context.read<RateBookingCubit>().submit(
                        rating: _rating,
                        comment: _commentController.text,
                      ),
                customChild: state.status.isLoading
                    ? SizedBox.square(
                        dimension: 22.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
          Icons.workspace_premium,
          color: AppColors.bookingRatingOrange,
          size: 48.r,
        ),
        SizedBox(height: 20.h),
        Text(
          LocaleKeys.bookingsRateStadium,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.main,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRow() {
    return Container(
      height: 40.h,
      padding: EdgeInsets.only(bottom: 16.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.bookingRatingBorder),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLabel(LocaleKeys.bookingsRatingLabel),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: List.generate(5, (index) {
                final star = index + 1;
                return Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: index == 4 ? 0 : 8.w,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _rating = star),
                    child: Icon(
                      star <= _rating ? Icons.star : Icons.star_border,
                      color: AppColors.bookingRatingOrange,
                      size: 25.8.r,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: _buildLabel(LocaleKeys.bookingsCommentLabel),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 80.h,
          child: TextField(
            controller: _commentController,
            maxLines: null,
            expands: true,
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(
              color: AppColors.main,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: LocaleKeys.bookingsRatingHint,
              hintTextDirection: TextDirection.rtl,
              hintStyle: TextStyle(
                color: AppColors.secondaryHintText,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              filled: true,
              fillColor: AppColors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              border: _commentBorder,
              enabledBorder: _commentBorder,
              focusedBorder: _commentBorder,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      textAlign: TextAlign.right,
      style: TextStyle(
        color: AppColors.main,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        height: 1.7,
      ),
    );
  }

  OutlineInputBorder get _commentBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: const BorderSide(color: AppColors.bookingRatingBorder),
    );
  }
}
