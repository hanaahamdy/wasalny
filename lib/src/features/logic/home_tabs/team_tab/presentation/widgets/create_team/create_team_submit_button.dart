part of '../../imports/view_imports.dart';

class _CreateTeamSubmitButton extends StatelessWidget {
  const _CreateTeamSubmitButton();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CreateTeamCubit cubit) => cubit.state.isLoading,
    );

    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 18.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .05),
            blurRadius: 24.r,
            offset: Offset(0, -6.h),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: LoadingButton(
          title: LocaleKeys.confirm,
          height: AppSize.sH56,
          borderRadius: AppCircular.infinity,
          color: AppColors.primary,
          isDissabled: isLoading,
          onTap: context.read<CreateTeamCubit>().submit,
        ),
      ),
    );
  }
}
