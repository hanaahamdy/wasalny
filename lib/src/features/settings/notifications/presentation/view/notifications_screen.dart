part of '../imports/view_imports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<NotificationsCubit>()..fetchInitialData(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.authTabSelected,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: CustomAppbar(title: LocaleKeys.notificationsTitle),
          backgroundColor: AppColors.scaffoldBackground,
          body: Column(
            children: [
              Expanded(
                child: Transform.translate(
                  offset: Offset(0, -AppSize.sH1),
                  child: const _NotificationBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
