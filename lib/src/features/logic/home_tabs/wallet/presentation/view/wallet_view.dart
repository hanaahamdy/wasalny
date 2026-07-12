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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.bookingHeaderGreen,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: AppColors.subtleBackground,
          body: BlocBuilder<WalletCubit, AsyncState<WalletEntity?>>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _WalletHeader(title: LocaleKeys.wallet),
                  ),
                  if (state.isLoading || state.data == null)
                    const SliverFillRemaining(
                      child: Center(child: LoadingIndicator()),
                    )
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
                      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 28.h),
                      sliver: SliverList.list(
                        children: [_WalletBalanceCard(wallet: state.data!)],
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
