part of '../imports/presentation_imports.dart';

class EmployeeTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const EmployeeTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scenarioSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppCircular.r12),
        side: BorderSide(color: AppColors.scenarioBorder),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        child: Padding(
          padding: EdgeInsets.all(AppPadding.pW14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.moreIconBackground,
                child: Icon(icon, color: AppColors.scenarioPrimary),
              ),
              SizedBox(width: AppSize.sW12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.scenarioText,
                    fontSize: FontSizeManager.s14,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ),
              Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.chevron_left
                    : Icons.chevron_right,
                color: AppColors.scenarioMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
