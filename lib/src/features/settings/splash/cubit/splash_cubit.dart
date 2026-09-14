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
    if (!isLoggedIn) {
      Go.offAll(const LoginScreen());
      return;
    }

    final destination = switch (UserCubit.instance.user.role) {
      UserRole.buyer => const BuyerScreen(),
      UserRole.packing => const PackingScreen(),
      UserRole.aliaa => const AliaaScreen(),
      UserRole.admin || UserRole.delivery => const HomeScreen(),
    };
    Go.offAll(destination);
  }
}
