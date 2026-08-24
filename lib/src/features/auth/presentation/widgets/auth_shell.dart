part of '../imports/view_imports.dart';

class AuthShell extends StatelessWidget {
  final Widget child;

  const AuthShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(gradient: AppColors.buttonGradient),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.pW20,
                  vertical: AppPadding.pH28,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AuthBrand(),
                    SizedBox(height: AppSize.sH28),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
