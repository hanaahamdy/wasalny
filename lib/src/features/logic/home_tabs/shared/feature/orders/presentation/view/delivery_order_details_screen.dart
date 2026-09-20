part of '../imports/view_imports.dart';

class DeliveryOrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const DeliveryOrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: CustomAppBar(title: LocaleKeys.orderDetails),
        body: OrderDetailsBody(
          order: order,
          actions: DeliveryOrderDetailsActions(
            status: order.deliveryTab,
            onStartDelivery: () {},
            onDelivered: () {},
          ),
        ),
      ),
    );
  }
}
