part of '../wallet_feature.dart';

class _WalletBalanceCard extends StatelessWidget {
  final WalletEntity wallet;

  const _WalletBalanceCard({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 228.h,
      margin: EdgeInsets.only(bottom: 18.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 24.r,
            offset: Offset(0, 16.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            Positioned.fill(
              child: AppAssets.svg.baseSvg.walletCard.image(fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(22.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              LocaleKeys.bookingsWalletBalance,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.account_balance_wallet,
                              color: AppColors.white,
                              size: 22.r,
                            ),
                          ],
                        ),
                        _WalletSmallChip(
                          label: wallet.country,
                          color: AppColors.white.withValues(alpha: .22),
                          textColor: AppColors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      LocaleKeys.bookingsCurrentBalance,
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: .76),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${wallet.balance}',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 34.sp,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          LocaleKeys.bookingsRiyal,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              LocaleKeys.bookingsLastRecharge,
                              style: TextStyle(
                                color: AppColors.white.withValues(alpha: .50),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              LocaleKeys.bookingsRechargeSummary(
                                amount: '${wallet.lastRecharge}',
                                currency: LocaleKeys.bookingsRiyal,
                                date: wallet.lastRechargeDate,
                              ),
                              style: TextStyle(
                                color: AppColors.white.withValues(alpha: .82),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        _WalletRechargeButton(onTap: () {}),
                      ],
                    ),
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
