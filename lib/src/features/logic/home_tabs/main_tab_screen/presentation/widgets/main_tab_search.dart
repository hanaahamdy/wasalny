import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/language/locale_keys.g.dart';
import '../../../../../../config/res/config_imports.dart';

class MainTabSearch extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onSearch;
  final VoidCallback? onFilter;
  final bool readOnly;

  const MainTabSearch({
    super.key,
    required this.onSearch,
    this.controller,
    this.onFilter,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      padding: EdgeInsetsDirectional.only(start: 12.w, end: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 32.h,
            child: ElevatedButton(
              onPressed: onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.stadiumSectionAction,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(LocaleKeys.search, style: TextStyle(fontSize: 11.sp)),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: readOnly ? onSearch : null,
              onSubmitted: readOnly ? null : (_) => onSearch(),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: LocaleKeys.stadiumsSearchHint,
                hintStyle: TextStyle(
                  color: AppColors.hintText,
                  fontSize: 13.sp,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
              ),
            ),
          ),
          Icon(Icons.search, color: AppColors.hintText, size: 22.r),
          if (onFilter != null) ...[
            SizedBox(width: 8.w),
            InkWell(
              onTap: onFilter,
              borderRadius: BorderRadius.circular(18.r),
              child: Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: AppColors.stadiumFilterIconBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.stadiumFilterIconBorder),
                ),
                child: Icon(
                  Icons.tune,
                  color: AppColors.stadiumSectionAction,
                  size: 19.r,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
