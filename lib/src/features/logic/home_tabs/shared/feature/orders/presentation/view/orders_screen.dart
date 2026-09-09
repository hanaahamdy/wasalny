part of '../imports/view_imports.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocProvider(
      create: (_) => OrdersCubit(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppColors.systemUiOverlayStyle,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(LocaleKeys.orders),
          ),
          backgroundColor: AppColors.scenarioBackground,
          body: const OrdersBody(),
        ),
      ),
    );
  }
}
