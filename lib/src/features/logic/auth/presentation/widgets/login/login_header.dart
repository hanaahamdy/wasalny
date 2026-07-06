part of '../../imports/view_imports.dart';

class _LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.login,
                textAlign: TextAlign.start,
                style: const TextStyle().setMainTextColor.s20.bold,
              ),
              AppSize.sH10.szH,
              Text(
                LocaleKeys.loginSubtitle,
                textAlign: TextAlign.start,
                style: const TextStyle().setHintColor.s12.regular,
              ),
            ],
          ),
        ),
        AppSize.sW12.szW,
        Container(
          width: AppSize.sW40,
          height: AppSize.sH40,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppCircular.r8),
          ),
          child: Icon(
            Icons.translate,
            color: AppColors.primary,
            size: AppSize.sH22,
          ),
        ),
      ],
    );
  }
}

class _LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppAssets.svg.appSvg.appLogoPng.image(
      width: 118,
      height: 118,
      fit: BoxFit.contain,
    );
  }
}

class _CountryCodeBox extends StatelessWidget {
  const _CountryCodeBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.sW74,
      height: AppSize.sH55,
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F8),
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('+966', style: const TextStyle().setHintColor.s12.regular),
          AppSize.sH4.szH,
          Container(
            width: AppSize.sW27,
            height: AppSize.sH18,
            decoration: BoxDecoration(
              color: const Color(0xff006C35),
              borderRadius: BorderRadius.circular(AppCircular.r2),
            ),
            alignment: Alignment.center,
            child: Text('KSA', style: const TextStyle().setWhiteColor.s8.bold),
          ),
        ],
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  final LoginParams params;

  const _PhoneField({required this.params});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextFiled(
                controller: params.phoneController,
                hint: LocaleKeys.pleaseEnterYourPhoneNumber,
                title: null,
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                borderRadius: BorderRadius.circular(AppCircular.r20),
                validator: (value) => Validators.validatePhone(
                  value,
                  fieldTitle: LocaleKeys.phoneNumber,
                ),
              ),
            ),
            AppSize.sW10.szW,
            const _CountryCodeBox(),
          ],
        ),
      ],
    );
  }
}
