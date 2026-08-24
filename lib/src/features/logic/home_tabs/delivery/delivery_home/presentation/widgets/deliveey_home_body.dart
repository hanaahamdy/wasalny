part of '../imports/presentation_imports.dart';
class DeliveryHomeBody extends StatelessWidget {
  const DeliveryHomeBody({super.key});

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
                const DeliveryHomeOrderSummaryCards(),
                12.szH,
                ViewAllOrdersWidget(title: LocaleKeys.createdOrders),
                SizedBox(height: AppSize.sH10),
                ...OrderModel.samples.map(
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
