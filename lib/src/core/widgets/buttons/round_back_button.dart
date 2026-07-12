import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/res/config_imports.dart';

class RoundBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const RoundBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: .28),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white.withValues(alpha: .35)),
        ),
        child: Icon(Icons.arrow_back, color: AppColors.white, size: 20.r),
      ),
    );
  }
}
