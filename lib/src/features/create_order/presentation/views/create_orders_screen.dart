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
        listener: (context, state) {
          if (state.errorMessage != null) {
            MessageUtils.showSnackBar(
              context: context,
              baseStatus: BaseStatus.error,
              message: state.errorMessage!,
            );
          } else if (state.isSuccess) {
            if (state.successMessage?.isNotEmpty == true) {
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.success,
                message: state.successMessage!,
              );
            }
            Go.back(state.createdOrder);
          }
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: AppColors.authTabSelected,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: Scaffold(
            appBar: AppBar(title: Text(LocaleKeys.addOrder)),
            backgroundColor: AppColors.scaffoldBackground,
            body: const SafeArea(child: CreateOrdersBody()),
          ),
        ),
      ),
    );
  }
}
