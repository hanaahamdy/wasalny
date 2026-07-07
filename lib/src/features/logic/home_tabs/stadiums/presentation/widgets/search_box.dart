part of '../imports/stadiums_imports.dart';

class _SearchBox extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onSearch;
  final VoidCallback? onTap;
  final bool readOnly;

  const _SearchBox({
    required this.onSearch,
    this.controller,
    this.onTap,
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
                backgroundColor: const Color(0xFF3DBB85),
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
              onTap: onTap,
              onSubmitted: (_) => onSearch(),
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
        ],
      ),
    );
  }
}
