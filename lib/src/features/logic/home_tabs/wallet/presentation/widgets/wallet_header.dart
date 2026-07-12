part of '../wallet_feature.dart';

class _WalletHeader extends StatelessWidget {
  final String title;

  const _WalletHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 58.h, 16.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.bookingHeaderGreen,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
