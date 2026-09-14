import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/res/config_imports.dart';
import '../extensions/text_style_extensions.dart';
import '../navigation/navigator.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppSize.sH70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppSize.sH70,
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      foregroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? IconButton(
              onPressed: Go.back,
              icon: Icon(Icons.arrow_back, color: AppColors.white, size: 24.r),
            )
          : null,
      actions: actions,
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(gradient: AppColors.scenarioGradient),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 56.w),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle().setWhiteColor.s16.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
