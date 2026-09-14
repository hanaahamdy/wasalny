part of '../imports/presentation_imports.dart';

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
      child: BlocListener<CreateOrdersCubit, CreateOrdersState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            (!previous.isSuccess && current.isSuccess),
        listener: (context, state) async {
          if (state.errorMessage != null) {
            MessageUtils.showSnackBar(
              context: context,
              baseStatus: BaseStatus.error,
              message: state.errorMessage!,
            );
          } else if (state.isSuccess) {
            await successDialog(
              context: context,
              title: LocaleKeys.orderCreatedSuccessfully,
              afterSuccess: () => Go.back(state.createdOrder),
            );
          }
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: AppColors.scenarioPrimary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: Scaffold(
            appBar: CustomAppBar(title: LocaleKeys.addOrder),
            backgroundColor: AppColors.scaffoldBackground,
            body: const SafeArea(child: CreateOrdersBody()),
          ),
        ),
      ),
    );
  }
}
