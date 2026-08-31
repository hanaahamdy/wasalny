part of '../imports/presentation_imports.dart';

class AdminSalesFilterButton extends StatelessWidget {
  final VoidCallback onTap;

  const AdminSalesFilterButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppCircular.r10),
        child: Ink(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: AppPadding.pH12),
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(AppCircular.r10),
          ),
          child: Text(
            LocaleKeys.applyFilter,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: FontSizeManager.s12,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        ),
      ),
    );
  }
}
