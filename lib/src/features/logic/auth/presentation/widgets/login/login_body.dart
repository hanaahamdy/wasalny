part of '../../imports/view_imports.dart';

class _LoginBody extends StatefulWidget {
  const _LoginBody();

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final LoginParams params = LoginParams();

  @override
  void dispose() {
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginCubit>().state;

    return Form(
      key: params.formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.pW24, vertical: AppPadding.pH16),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _LoginHeader(),
            20.szH,
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.pW24, vertical: AppPadding.pH16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppCircular.r20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: _LoginLogo()),
                  AppSize.sH28.szH,
                  _PhoneField(params: params),
                  AppSize.sH18.szH,
                  CustomTextFiled(
                    controller: params.passwordController,
                    hint: LocaleKeys.pleaseEnterYourPassword,
                    title: LocaleKeys.password,
                    isPassword: true,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    borderRadius: BorderRadius.circular(AppCircular.r20),
                    validator: (value) => Validators.validateEmpty(
                      value,
                      fieldTitle: LocaleKeys.password,
                    ),
                  ),
                  AppSize.sH10.szH,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(AppSize.sW40, AppSize.sH35),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        LocaleKeys.forgotPassword,
                        style: const TextStyle().setHintColor.s13.regular,
                      ),
                    ),
                  ),
                  AppSize.sH10.szH,
                  LoadingButton(
                    title: LocaleKeys.login,
                    height: AppSize.sH56,
                    borderRadius: AppCircular.r20,
                    color: AppColors.primary,
                    isDissabled: state.status.isLoading,
                    onTap: () => context.read<LoginCubit>().login(params),
                  ),
                  AppSize.sH24.szH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.doNotHaveAnAccount,
                        style: const TextStyle().setHintColor.s13.regular,
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.pW4,
                          ),
                          minimumSize: Size(AppSize.sW40, AppSize.sH35),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          LocaleKeys.register,
                          style: const TextStyle()
                              .setColor(const Color(0xff003D31))
                              .s13
                              .bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
