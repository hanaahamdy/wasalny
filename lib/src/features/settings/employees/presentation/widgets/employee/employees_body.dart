part of '../../imports/presentation_imports.dart';

class EmployeesBody extends StatelessWidget {
  final EmployeesViewModel viewModel;

  const EmployeesBody({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final employees = viewModel.employees;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW12,
        vertical: AppPadding.pH14,
      ),
      child: Column(
        children: [
          TextField(
            onChanged: viewModel.search,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: LocaleKeys.search,
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppCircular.r10),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppCircular.r10),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
            ),
          ),
          SizedBox(height: AppSize.sH14),
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(viewModel.errorMessage!),
                        SizedBox(height: AppSize.sH10),
                        TextButton(
                          onPressed: viewModel.load,
                          child: Text(LocaleKeys.retry),
                        ),
                      ],
                    ),
                  )
                : employees.isEmpty
                ? Center(child: Text(LocaleKeys.noResultFound))
                : ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: employees.length,
                    separatorBuilder: (_, _) => SizedBox(height: AppSize.sH10),
                    itemBuilder: (_, index) => EmployeeCard(
                      employee: employees[index],
                      onChanged: viewModel.load,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
