part of '../imports/contact_us_imports.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ContactUsCubit>(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.authTabSelected,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: CustomAppbar(title: LocaleKeys.contactUs),
          backgroundColor: AppColors.scaffoldBackground,
          body: const _ContactUsBody(),
        ),
      ),
    );
  }
}
