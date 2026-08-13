part of '../imports/view_imports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ChangePhonePasswordCubit()),
        BlocProvider(create: (_) => injector<NotifiyCubit>()),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.bookingHeaderGreen,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: AppColors.subtleBackground,
          appBar: CustomAppbar(title: LocaleKeys.moreGeneralSettings),
          body: const _SettingsTabBody(),
        ),
      ),
    );
  }
}
