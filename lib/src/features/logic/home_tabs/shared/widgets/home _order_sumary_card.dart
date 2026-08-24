import 'package:flutter/material.dart';
import '../../../../../config/res/config_imports.dart';
class HomeOrderSummaryCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;

  const HomeOrderSummaryCard({super.key,
    required this.value,
    required this.label,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sH100,
      padding: EdgeInsets.all(AppPadding.pW10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              width: AppSize.sW28,
              height: AppSize.sW28,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(AppCircular.r8),
              ),
              child: Icon(icon, color: iconColor, size: AppSize.sH17),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: AppColors.main,
              fontSize: FontSizeManager.s18,
              fontWeight: FontWeightManager.bold,
            ),
          ),

          Text(
            label,
            style: TextStyle(
              color: AppColors.hintText,
              fontSize: FontSizeManager.s10,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ],
      ),
    );
  }
}
