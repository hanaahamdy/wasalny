part of '../imports/presentation-imports.dart';

class CreateOrdersScreen extends StatelessWidget {
  const CreateOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocProvider(
      create: (_) => CreateOrdersCubit(),
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
    );
  }
}
