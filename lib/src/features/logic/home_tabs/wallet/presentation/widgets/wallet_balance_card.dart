part of '../wallet_feature.dart';

class _WalletBalanceCard extends StatelessWidget {
  final WalletEntity wallet;

  const _WalletBalanceCard({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.walletBalanceBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.bookingsCurrentBalance,
                style: TextStyle(
                  color: AppColors.notificationText,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8.w),
              AppAssets.svg.baseSvg.wallet.svg(
                width: 24.r,
                height: 24.r,
                colorFilter: const ColorFilter.mode(
                  AppColors.authTabSelected,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            '${wallet.balance.toStringAsFixed(2)} ${LocaleKeys.bookingsRiyal}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.authTabSelected,
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
