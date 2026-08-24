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
    await UserCubit.instance.init();
    await minimumSplashDuration;

    if (!context.mounted) return;
    Go.offAll(const IntroScreen());
  }
}
