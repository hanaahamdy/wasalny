import 'package:flutter/material.dart';

import '../../../../../config/res/config_imports.dart';

class HomeOrderSummaryCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;

  const HomeOrderSummaryCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sH120,
      padding: EdgeInsets.all(AppPadding.pW10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: Container(
              width: AppSize.sW50,
              height: AppSize.sW50,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(AppCircular.r8),
              ),
              child: Icon(icon, color: iconColor, size: AppSize.sH30),
            ),
          ),
          const Spacer(),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.main,
              fontSize: FontSizeManager.s18,
              fontWeight: FontWeightManager.bold,
            ),
          ),

          Text(
            label,
            textAlign: TextAlign.center,
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
