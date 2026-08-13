part of '../imports/contact_us_imports.dart';

class _ContactUsBody extends StatefulWidget {
  const _ContactUsBody();

  @override
  State<_ContactUsBody> createState() => _ContactUsBodyState();
}

class _ContactUsBodyState extends State<_ContactUsBody> {
  final ContactUsParams params = ContactUsParams();

  @override
  void dispose() {
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ContactUsCubit>();
    return Form(
      key: params.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppPadding.pW24,
                AppPadding.pH18,
                AppPadding.pW24,
                AppPadding.pH20,
              ),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(minHeight: 679.h),
                padding: EdgeInsets.fromLTRB(
                  AppPadding.pW16,
                  AppPadding.pH28,
                  AppPadding.pW16,
                  AppPadding.pH28,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.contactCardShadow,
                      blurRadius: 62.r,
                      offset: Offset.zero,
                    ),
                  ],
                ),
                child: CustomTextFiled(
                  hint: LocaleKeys.messageHint,
                  title: LocaleKeys.messageLabel,
                  isOptional: true,
                  controller: params.messageController,
                  maxLines: ConstantManager.maxLines,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  fillColor: AppColors.fieldFillColor,
                  hasBorder: false,
                  borderRadius: BorderRadius.circular(16.r),
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.hintText,
                    size: 24.r,
                  ),
                  validator: (value) => Validators.validateEmpty(value),
                ),
              ),
            ),
          ),
          _ContactUsBottomBar(
            isLoading: context.watch<ContactUsCubit>().isLoading,
            onSend: () => cubit.contactUs(params),
          ),
        ],
      ),
    );
  }
}

class _ContactUsBottomBar extends StatelessWidget {
  final bool isLoading;
  final Future<void> Function() onSend;

  const _ContactUsBottomBar({required this.isLoading, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91.h,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppPadding.pW24,
        AppPadding.pH16,
        AppPadding.pW24,
        AppPadding.pH18,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
          top: BorderSide(color: AppColors.contactBottomBarBorder),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.contactBottomBarShadow,
            blurRadius: 6.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: LoadingButton(
        title: LocaleKeys.sendBtn,
        color: AppColors.primary,
        textColor: AppColors.white,
        height: 56.h,
        borderRadius: 50.r,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        isDissabled: isLoading,
        onTap: onSend,
      ),
    );
  }
}
