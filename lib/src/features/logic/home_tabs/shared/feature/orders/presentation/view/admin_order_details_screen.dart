part of '../imports/view_imports.dart';

class AdminOrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const AdminOrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocProvider(
      create: (_) => AdminOrderDetailsCubit(order: order)..fetchOrderDetails(),
      child: BlocListener<AdminOrderDetailsCubit, RequestState<OrderModel>>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage &&
            current.errorMessage != null,
        listener: (context, state) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.errorMessage!))),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: Scaffold(
            appBar: CustomAppBar(
              title: LocaleKeys.orderDetails,
              actions: [
                BlocBuilder<AdminOrderDetailsCubit, RequestState<OrderModel>>(
                  builder: (context, state) => IconButton(
                    tooltip: LocaleKeys.printA5,
                    icon: const Icon(Icons.print_outlined),
                    onPressed: () => Go.to(A5InvoiceScreen(order: state.data)),
                  ),
                ),
              ],
            ),
            body: BlocBuilder<AdminOrderDetailsCubit, RequestState<OrderModel>>(
              builder: (context, state) => Stack(
                children: [
                  OrderDetailsBody(
                    order: state.data,
                    actions: AdminOrderDetailsActions(
                      status: state.data.adminTab,
                      onCancelOrder: () {},
                      onResendOrder: () {},
                      onTrackOrder: () {},
                    ),
                  ),
                  if (state.isLoading)
                    const LinearProgressIndicator(minHeight: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
