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
          backgroundColor: AppColors.scaffoldBackground,
          body: Column(
            children: [
              const _NotificationsHeader(),
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

class _NotificationsHeader extends StatelessWidget {
  const _NotificationsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 121.h,
      width: double.infinity,
      padding: EdgeInsets.only(
        left: AppPadding.pW20,
        right: AppPadding.pW20,
        top: context.viewPadding.top,
      ),
      decoration: BoxDecoration(
        color: AppColors.authTabSelected,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppCircular.r12),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PositionedDirectional(
            end: 0,
            top: 47.h - context.viewPadding.top,
            child: Icon(
              context.isRight ? Icons.arrow_forward : Icons.arrow_back,
              color: AppColors.white,
              size: 24.r,
            ).onClick(onTap: () => Go.back()),
          ),
          Positioned(
            top: 51.h - context.viewPadding.top,
            child: Text(
              LocaleKeys.notificationsTitle,
              style: const TextStyle().setWhiteColor.s16.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
