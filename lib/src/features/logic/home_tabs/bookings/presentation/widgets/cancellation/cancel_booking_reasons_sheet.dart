part of '../../bookings_feature.dart';

class _CancelBookingReasonsSheet extends StatelessWidget {
  const _CancelBookingReasonsSheet();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CancelReasonsCubit()..fetchCancelReasons(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.bookingRatingBorder,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(height: 26.h),
                Text(
                  LocaleKeys.bookingsCancelReasonTitle,
                  style: const TextStyle().s14.semiBold.setBlackColor,
                ),
                SizedBox(height: 20.h),
                BlocBuilder<
                  CancelReasonsCubit,
                  AsyncState<List<CancelReasonEntity>>
                >(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return SizedBox(
                        height: 236.h,
                        child: CustomLoading.showLoadingView(),
                      );
                    }
                    if (state.status.isError) {
                      return SizedBox(
                        height: 236.h,
                        child: Center(
                          child: Text(
                            state.errorMessage ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.hintText,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      );
                    }

                    final cancelReasonsCubit = context
                        .read<CancelReasonsCubit>();
                    final selectedReason = cancelReasonsCubit.selectedReason;
                    return Column(
                      children: [
                        ...state.data.map(
                          (reason) => Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: _CancelReasonTile(
                              reason: reason,
                              isSelected: reason.isSelected,
                              onTap: () =>
                                  cancelReasonsCubit.selectReason(reason),
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        DefaultButton(
                          title: LocaleKeys.bookingsConfirmCancel,
                          height: 56.h,
                          color: AppColors.moreLogoutText,
                          borderRadius: BorderRadius.circular(50.r),
                          fontSize: 16.sp,
                          onTap: selectedReason == null
                              ? null
                              : () => Go.back(selectedReason),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CancelReasonTile extends StatelessWidget {
  final CancelReasonEntity reason;
  final bool isSelected;
  final VoidCallback onTap;

  const _CancelReasonTile({
    required this.reason,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.fieldFillColor,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              _CancelReasonRadio(isSelected: isSelected),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  reason.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: AppColors.hintText).medium.s12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CancelReasonRadio extends StatelessWidget {
  final bool isSelected;

  const _CancelReasonRadio({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.r,
      height: 24.r,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        border: Border.all(
          color: isSelected ? AppColors.moreLogoutText : AppColors.white,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.moreLogoutText : AppColors.transparent,
        ),
      ),
    );
  }
}
