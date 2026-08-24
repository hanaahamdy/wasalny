part of '../imports/view_imports.dart';

class IntroBody extends StatelessWidget {
  final IntroViewModel viewModel;

  const IntroBody({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        final slide = viewModel.currentSlide;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: Container(
            width: context.width,
            height: context.height,
            decoration: const BoxDecoration(gradient: AppColors.buttonGradient),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.pW20,
                  vertical: AppPadding.pH20,
                ),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    IntroLogo(slide: slide),
                    SizedBox(height: AppSize.sH100),
                    const Spacer(),
                    IntroIndicator(
                      currentIndex: viewModel.currentIndex,
                      count: viewModel.indicatorCount,
                    ),
                    SizedBox(height: AppSize.sH22),
                    IntroStartButton(onTap: () => viewModel.start(context)),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
