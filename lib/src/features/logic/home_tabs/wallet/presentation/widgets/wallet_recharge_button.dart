part of '../wallet_feature.dart';

class _WalletRechargeButton extends StatelessWidget {
  final VoidCallback onTap;

  const _WalletRechargeButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: SizedBox(
          width: 144.w,
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle,
                color: AppColors.walletActionGreen,
                size: 16.r,
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  LocaleKeys.bookingsRechargeBalance,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.walletActionGreen,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
