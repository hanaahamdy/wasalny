part of '../imports/presentation_imports.dart';

class DeliveryHomeBody extends StatelessWidget {
  const DeliveryHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: context.read<DeliveryHomeCubit>().fetchHome,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                vertical: AppPadding.pH12,
                horizontal: AppPadding.pW12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const DeliveryHomeOrderSummaryCards(),
                  12.szH,
                  const _DeliveryLatestOrders(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DeliveryLatestOrders extends StatelessWidget {
  const _DeliveryLatestOrders();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryHomeCubit, RequestState<DeliveryHomeModel?>>(
      builder: (context, state) {
        final orders = state.data?.latestOrders ?? const <OrderModel>[];
        if (orders.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ViewAllOrdersWidget(title: LocaleKeys.latestOrders),
            SizedBox(height: AppSize.sH10),
            ...orders.map(
              (order) => Padding(
                padding: EdgeInsets.only(bottom: AppPadding.pH10),
                child: OrderCard(order: order),
              ),
            ),
          ],
        );
      },
    );
  }
}
