part of '../../imports/view_imports.dart';

class _LoginFormCard extends StatelessWidget {
  final LoginParams params;
  final _LoginTab selectedTab;
  final ValueChanged<_LoginTab> onTabChanged;

  const _LoginFormCard({
    required this.params,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW16,
        vertical: AppPadding.pH12,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r20 + 4.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 55.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: AppLogoWidget(size: 120.h)),
          AppSize.sH30.szH,
          _LoginTabs(selectedTab: selectedTab, onChanged: onTabChanged),
          AppSize.sH16.szH,
          _LoginIdentifierField(params: params, selectedTab: selectedTab),
          AppSize.sH12.szH,
          _LoginPasswordField(params: params),
          const _ForgotPasswordButton(),
          LoadingButton(
            title: LocaleKeys.login,
            height: AppSize.sH56,
            borderRadius: AppCircular.infinity,
            color: AppColors.primary,
            isDissabled: state.status.isLoading,
            onTap: () => context.read<LoginCubit>().login(params),
          ),
          AppSize.sH14.szH,
          const _RegisterPrompt(),
        ],
      ),
    );
  }
}
