part of '../imports/view_imports.dart';

class _HomeDashboard extends StatelessWidget {
  const _HomeDashboard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case BaseStatus.initial:
          case BaseStatus.loading:
          case BaseStatus.loadingMore:
            return CustomLoading.showLoadingView();
          case BaseStatus.error:
            return ErrorView(error: state.errorMessage);
          case BaseStatus.success:
            final data = state.data;
            if (data == null) {
              return ErrorView(error: LocaleKeys.exceptionError);
            }
            return UserCubit.instance.user.userType == UserType.admin
                ? AdminHome(data: data)
                : DeliveryHomeScreen(data: data);
        }
      },
    );
  }
}
