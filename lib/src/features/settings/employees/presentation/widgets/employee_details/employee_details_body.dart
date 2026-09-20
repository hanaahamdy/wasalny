part of '../../imports/presentation_imports.dart';

class EmployeeDetailsBody extends StatelessWidget {
  final EmployeeDetailsViewModel viewModel;

  const EmployeeDetailsBody({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.errorMessage != null) {
      return Center(child: Text(viewModel.errorMessage!));
    }
    final employee = viewModel.employee;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW8,
        vertical: AppPadding.pH12,
      ),
      child: Column(
        children: [
          EmployeeProfileCard(employee: employee),
          SizedBox(height: AppSize.sH10),
          DefaultButton(
            width: double.infinity,
            height: AppSize.sH45,
            title: LocaleKeys.editEmployeeData,
            onTap: () async {
              final updated = await Go.to<EmployeeModel>(
                EditEmployeeProfileScreen(employee: employee),
              );
              if (updated != null) viewModel.replace(updated);
            },
            customChild: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.editEmployeeData,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: FontSizeManager.s12,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
                SizedBox(width: AppSize.sW6),
                Icon(
                  Icons.edit_outlined,
                  color: AppColors.white,
                  size: AppSize.sH16,
                ),
              ],
            ),
          ),
          SizedBox(height: AppSize.sH10),
          DefaultButton(
            width: double.infinity,
            height: AppSize.sH45,
            title: LocaleKeys.disableAccount,
            color: AppColors.white,
            textColor: AppColors.main,
            borderColor: AppColors.inputBorder,
            onTap: null,
          ),
          SizedBox(height: AppSize.sH10),
          DefaultButton(
            width: double.infinity,
            height: AppSize.sH45,
            title: LocaleKeys.deleteEmployee,
            color: AppColors.error,
            onTap: () async {
              if (await viewModel.delete()) Go.back(true);
            },
            customChild: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.deleteEmployee,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: FontSizeManager.s12,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
                SizedBox(width: AppSize.sW6),
                Icon(
                  Icons.delete_outline,
                  color: AppColors.white,
                  size: AppSize.sH16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
