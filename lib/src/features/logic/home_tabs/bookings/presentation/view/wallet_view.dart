part of '../bookings_feature.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  late final WalletCubit _cubit = WalletCubit()..loadWallet();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.subtleBackground,
          body: BlocBuilder<WalletCubit, WalletEntity?>(
            builder: (context, wallet) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _BookingHeader(title: LocaleKeys.wallet),
                  ),
                  if (wallet == null)
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 28.h),
                      sliver: SliverList.list(
                        children: [
                          _WalletBalanceCard(wallet: wallet),
                          SizedBox(height: 18.h),
                          _WalletActionCard(wallet: wallet),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _WalletBalanceCard extends StatelessWidget {
  final WalletEntity wallet;

  const _WalletBalanceCard({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 228.h,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1540379708242-14a809bef941?auto=format&fit=crop&w=900&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppColors.walletGradientStart.withValues(alpha: .92),
                    AppColors.walletGradientEnd.withValues(alpha: .86),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(22.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SmallChip(
                        label: wallet.country,
                        color: AppColors.white.withValues(alpha: .22),
                        textColor: AppColors.white,
                      ),
                      Row(
                        children: [
                          Text(
                            LocaleKeys.bookingsWalletBalance,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12.sp,
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
                    ],
                  ),
                  const Spacer(),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        LocaleKeys.bookingsPound,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${wallet.balance}',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 34.sp,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletActionCard extends StatelessWidget {
  final WalletEntity wallet;

  const _WalletActionCard({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 144.w,
            height: 42.h,
            child: DefaultButton(
              title: LocaleKeys.bookingsRechargeBalance,
              color: AppColors.white,
              textColor: AppColors.walletActionGreen,
              borderColor: AppColors.walletActionGreen,
              borderRadius: BorderRadius.circular(22.r),
              customChild: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.walletActionGreen,
                    size: 18.r,
                  ),
                  SizedBox(width: 6.w),
                  Flexible(
                    child: Text(
                      LocaleKeys.bookingsRechargeBalance,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.walletActionGreen,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                LocaleKeys.bookingsLastRecharge,
                style: TextStyle(
                  color: AppColors.hintText,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                LocaleKeys.bookingsRechargeSummary(
                  amount: '${wallet.lastRecharge}',
                  currency: LocaleKeys.bookingsPound,
                  date: wallet.lastRechargeDate,
                ),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
