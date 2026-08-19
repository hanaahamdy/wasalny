import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/res/config_imports.dart';
import '../extensions/text_style_extensions.dart';
import '../navigation/navigator.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppbar({super.key, required this.title, this.actions});

  @override
  Size get preferredSize => Size.fromHeight(121.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 121.h,
      backgroundColor: AppColors.authTabSelected,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Go.back(),
        icon: Icon(Icons.arrow_back, color: AppColors.white, size: 24.r),
      ),
      actions: actions,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
      ),
      flexibleSpace: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 18.h),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle().setWhiteColor.s16.bold,
            ),
          ),
        ),
      ),
    );
  }
}
