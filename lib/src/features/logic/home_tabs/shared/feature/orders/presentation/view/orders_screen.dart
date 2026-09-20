part of '../imports/view_imports.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocProvider(
      create: (_) => OrdersCubit()..fetchOrders(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppColors.systemUiOverlayStyle,
        child: Scaffold(
          appBar: CustomAppBar(
            automaticallyImplyLeading: false,
            title: LocaleKeys.orders,
          ),
          backgroundColor: AppColors.scenarioBackground,
          body: const OrdersBody(),
        ),
      ),
    );
  }
}
