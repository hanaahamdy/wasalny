part of '../imports/presentation-imports.dart';

class CreateOrdersScreen extends StatelessWidget {
  final String initialCustomerName;
  final String initialCustomerPhone;

  const CreateOrdersScreen({
    super.key,
    this.initialCustomerName = '',
    this.initialCustomerPhone = '',
  });

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocProvider(
      create: (_) => CreateOrdersCubit()
        ..prefillCustomer(
          name: initialCustomerName,
          phone: initialCustomerPhone,
        ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.scenarioPrimary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.addOrder)),
          backgroundColor: AppColors.scaffoldBackground,
          body: const SafeArea(child: CreateOrdersBody()),
        ),
      ),
    );
  }
}
