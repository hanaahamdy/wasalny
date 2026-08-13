part of '../wallet_feature.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  late final WalletCubit _cubit = WalletCubit()..fetchWallet();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppbar(title: LocaleKeys.wallet),
        body: BlocBuilder<WalletCubit, AsyncState<WalletEntity?>>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state.status.isInitial || state.isLoading)
                  const _WalletLoadingSliver()
                else if (state.isError)
                  SliverFillRemaining(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Text(
                          state.errorMessage ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 28.h),
                    sliver: SliverList.list(
                      children: [
                        _WalletBalanceCard(wallet: state.data!),
                        SizedBox(height: 24.h),
                        _WalletRechargeButton(
                          onTap: () =>
                              showChargeWalletDialog(walletCubit: _cubit),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _WalletLoadingSliver extends StatelessWidget {
  const _WalletLoadingSliver();

  static const _placeholderWallet = WalletEntity(
    balance: 2500,
    lastRecharge: 0,
    lastRechargeDate: '',
    country: '',
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.sliver(
      enabled: true,
      child: SliverPadding(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 28.h),
        sliver: SliverList.list(
          children: [
            const _WalletBalanceCard(wallet: _placeholderWallet),
            SizedBox(height: 24.h),
            _WalletRechargeButton(onTap: () {}),
          ],
        ),
      ),
    );
  }
}
