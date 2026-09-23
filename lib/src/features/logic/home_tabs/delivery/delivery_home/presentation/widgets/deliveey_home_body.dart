part of '../imports/presentation_imports.dart';

class DeliveryHomeBody extends StatelessWidget {
  final HomeModel data;

  const DeliveryHomeBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: AppPadding.pH12,
              horizontal: AppPadding.pW12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DeliveryHomeOrderSummaryCards(data: data),
                12.szH,
                ViewAllOrdersWidget(title: LocaleKeys.createdOrders),
                SizedBox(height: AppSize.sH10),
                ...data.latestOrders.map(
                  (order) => Padding(
                    padding: EdgeInsets.only(bottom: AppPadding.pH10),
                    child: OrderCard(order: order),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
