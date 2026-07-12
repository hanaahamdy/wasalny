part of '../../imports/stadiums_imports.dart';

class _BookingConfirmButton extends StatelessWidget {
  final VoidCallback onConfirm;

  const _BookingConfirmButton({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 18.h),
      child: DefaultButton(
        title: LocaleKeys.confirm,
        height: 56.h,
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(28.r),
        onTap: onConfirm,
      ),
    );
  }
}
