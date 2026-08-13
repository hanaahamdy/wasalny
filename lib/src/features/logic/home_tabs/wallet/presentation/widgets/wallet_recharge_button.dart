part of '../wallet_feature.dart';

class _WalletRechargeButton extends StatelessWidget {
  final VoidCallback onTap;

  const _WalletRechargeButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.authTabSelected,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          width: double.infinity,
          height: 48.h,
          child: Center(
            child: Text(
              LocaleKeys.bookingsRechargeBalance,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
