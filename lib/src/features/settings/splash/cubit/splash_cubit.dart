part of '../imports/view_imports.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial());

  Future<void> initApp(BuildContext context) async {
    final minimumSplashDuration = Future<void>.delayed(
      const Duration(milliseconds: ConstantManager.splashTimer),
    );
    final baseUrlCubit = context.read<BaseUrlCubit>();
    final hasBaseUrl = await baseUrlCubit.fetchBaseUrl();
    if (!hasBaseUrl) return;

    await injector<NetworkService>().updateBaseUrl();
    final isLoggedIn = await UserCubit.instance.init();
    await minimumSplashDuration;

    if (!context.mounted) return;
    var hasNavigated = false;
    void navigateToInitialRoute() {
      if (hasNavigated) return;
      hasNavigated = true;
      _navigateByAuthState(isLoggedIn);
    }

    NotificationNavigator(
      onRoutingMessage: (message) {
        navigateToInitialRoute();
        if (isLoggedIn) {
          NotificationRoutes.navigateByType(message.data);
        }
      },
      onNoInitialMessage: navigateToInitialRoute,
    );
    await injector<NotificationService>().setupNotifications();
  }

  void _navigateByAuthState(bool isLoggedIn) {
    if (!isLoggedIn) {
      Go.offAll(const LoginScreen());
      return;
    }

    final user = UserCubit.instance.user;
    _applySystemType(user.systemType);
    _navigateToRoleCycle(user.userType);
  }

  void _navigateToRoleCycle(UserType userType) {
    switch (userType) {
      case UserType.admin:
      case UserType.delivery:
        Go.offAll(const HomeScreen());
      case UserType.buyer:
        Go.offAll(const BuyerScreen());
      case UserType.packing:
        Go.offAll(const PackingScreen());
      case UserType.aliaa:
        Go.offAll(const AliaaScreen());
    }
  }

  void _applySystemType(String systemType) {
    AppColors.selectedScenario = systemType.trim().toLowerCase() == 'system_two'
        ? AppColorScenario.second
        : AppColorScenario.first;
    SystemChrome.setSystemUIOverlayStyle(AppColors.systemUiOverlayStyle);
  }
}
