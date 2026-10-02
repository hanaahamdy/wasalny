part of '../imports/view_imports.dart';

class DeliveryOrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const DeliveryOrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocProvider(
      create: (_) => DeliveryOrderStatusCubit(order: order),
      child:
          BlocListener<
            DeliveryOrderStatusCubit,
            RequestState<DeliveryOrderTab>
          >(
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
                appBar: CustomAppBar(title: LocaleKeys.orderDetails),
                body:
                    BlocBuilder<
                      DeliveryOrderStatusCubit,
                      RequestState<DeliveryOrderTab>
                    >(
                      builder: (context, state) => Stack(
                        children: [
                          OrderDetailsBody(
                            order: order,
                            statusLabel: state.data.label,
                            actions: DeliveryOrderDetailsActions(
                              status: state.data,
                              isLoading: state.isLoading,
                              onStartDelivery: () => context
                                  .read<DeliveryOrderStatusCubit>()
                                  .startDelivery(),
                              onTrackOrder: () {},
                              onDelivered: () => context
                                  .read<DeliveryOrderStatusCubit>()
                                  .markAsDelivered(),
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
