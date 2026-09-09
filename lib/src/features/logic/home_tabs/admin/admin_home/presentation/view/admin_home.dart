part of '../../../../../home/presentation/imports/view_imports.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;

    return BlocProvider(
      create: (_) => AdminHomeCubit()..fetchHome(),
      child: const _AdminHomeView(),
    );
  }
}

class _AdminHomeView extends StatelessWidget {
  const _AdminHomeView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminHomeCubit, RequestState<AdminHomeModel?>>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage &&
          current.errorMessage != null,
      listener: (context, state) => MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: state.errorMessage!,
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: context.read<AdminHomeCubit>().fetchHome,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    AppPadding.pW8,
                    AppPadding.pH12,
                    AppPadding.pW8,
                    AppPadding.pH20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _AdminHomeStats(),
                      SizedBox(height: AppSize.sH14),
                      const AdminHomeActions(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminHomeStats extends StatelessWidget {
  const _AdminHomeStats();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminHomeCubit, RequestState<AdminHomeModel?>>(
      builder: (context, state) {
        final data = state.data;
        final loadingValue = state.isLoading && data == null ? '...' : null;

        return Row(
          children: [
            Expanded(
              child: HomeOrderSummaryCard(
                value: loadingValue ?? (data?.createdOrders ?? 0).toString(),
                label: LocaleKeys.orderCount,
                icon: Icons.inventory_2_outlined,
                iconBackground: AppColors.settingsLanguageIconBackground,
                iconColor: AppColors.settingsLanguageIcon,
              ),
            ),
            SizedBox(width: AppSize.sW8),
            Expanded(
              child: HomeOrderSummaryCard(
                value: loadingValue ?? (data?.deliveredOrders ?? 0).toString(),
                label: LocaleKeys.delivered,
                icon: Icons.local_shipping_outlined,
                iconBackground: AppColors.moreProfileIconBackground,
                iconColor: AppColors.authTabSelected,
              ),
            ),
          ],
        );
      },
    );
  }
}
