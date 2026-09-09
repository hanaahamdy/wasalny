part of '../imports/view_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => injector<BaseUrlCubit>()),
        BlocProvider(create: (context) => injector<SplashCubit>()),
      ],
      child: _SplashView(),
    );
  }
}

class _SplashView extends StatefulWidget {
  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().initApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          width: context.width,
          height: context.height,
          decoration: BoxDecoration(gradient: AppColors.scenarioGradient),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 62.w,
                    height: 62.w,
                    padding: EdgeInsets.all(AppPadding.pW14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppCircular.r15),
                    ),
                    child: AppAssets.svg.appSvg.appLogoPng.image(
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: AppSize.sH14),
                  Text(
                    LocaleKeys.splashWaslnyTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: FontSizeManager.s20,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                  SizedBox(height: AppSize.sH2),
                  Text(
                    LocaleKeys.splashWaslnySubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: FontSizeManager.s11,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
