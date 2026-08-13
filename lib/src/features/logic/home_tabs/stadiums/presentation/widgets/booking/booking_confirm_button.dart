part of '../../imports/stadiums_imports.dart';

class _BookingConfirmButton extends StatelessWidget {
  final VoidCallback onConfirm;
  final bool isLoading;

  const _BookingConfirmButton({
    required this.onConfirm,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 18.h),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.contactBottomBarBorder),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.contactBottomBarShadow,
            blurRadius: 6,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: DefaultButton(
          title: LocaleKeys.confirm,
          height: 56.h,
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(28.r),
          onTap: isLoading ? null : onConfirm,
          customChild: isLoading
              ? SizedBox.square(
                  dimension: 22.r,
                  child: const CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 2,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
