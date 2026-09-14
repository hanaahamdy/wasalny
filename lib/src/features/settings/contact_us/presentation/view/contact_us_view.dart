part of '../imports/contact_us_imports.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ContactUsCubit>(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value:  SystemUiOverlayStyle(
          statusBarColor: AppColors.scenarioPrimary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: CustomAppBar(title: LocaleKeys.contactUs),
          backgroundColor: AppColors.scaffoldBackground,
          body: const _ContactUsBody(),
        ),
      ),
    );
  }
}
