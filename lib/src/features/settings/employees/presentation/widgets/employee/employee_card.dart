part of '../../imports/presentation_imports.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeModel employee;
  final VoidCallback onChanged;

  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppCircular.r12),
        side: const BorderSide(color: AppColors.inputBorder),
      ),
      child: InkWell(
        onTap: () async {
          final changed = await Go.to<bool>(
            EmployeeDetailsScreen(employee: employee),
          );
          if (changed == true) onChanged();
        },
        borderRadius: BorderRadius.circular(AppCircular.r12),
        child: Padding(
          padding: EdgeInsets.all(AppPadding.pW12),
          child: Row(
            children: [
              CircleAvatar(
                radius: AppSize.sW25,
                backgroundColor: AppColors.moreIconBackground,
                child: Text(
                  employee.name.characters.first,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: FontSizeManager.s18,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ),
              SizedBox(width: AppSize.sW12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.main,
                        fontSize: FontSizeManager.s14,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                    SizedBox(height: AppSize.sH4),
                    Text(
                      employee.phone,
                      style: TextStyle(
                        color: AppColors.hintText,
                        fontSize: FontSizeManager.s11,
                      ),
                    ),
                    SizedBox(height: AppSize.sH4),
                    EmployeeStatusLabel(isActive: employee.isActive),
                  ],
                ),
              ),
              Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.chevron_left
                    : Icons.chevron_right,
                color: AppColors.grey2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
