part of '../imports/view_imports.dart';

class A5InvoiceScreen extends StatelessWidget {
  final OrderModel order;

  const A5InvoiceScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.scenarioBackground,
        appBar: CustomAppBar(title: LocaleKeys.a5PrintPreview),
        body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  AppPadding.pW12,
                  AppPadding.pH12,
                  AppPadding.pW12,
                  AppPadding.pH20,
                ),
                children: [
                  A5InvoiceCard(order: order),
                  SizedBox(height: AppSize.sH14),
                  DefaultButton(
                    customChild: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          LocaleKeys.print,
                          style: TextStyle(
                            color: AppColors.buttonText,
                            fontSize: FontSizeManager.s13,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(width: AppSize.sW8),
                        Icon(
                          Icons.print_outlined,
                          color: AppColors.buttonText,
                          size: AppSize.sH18,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: AppSize.sH10),
                  DefaultButton(
                    title: LocaleKeys.back,
                    color: AppColors.scenarioSurface,
                    textColor: AppColors.scenarioText,
                    borderColor: AppColors.scenarioBorder,
                    onTap: Go.back,
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
