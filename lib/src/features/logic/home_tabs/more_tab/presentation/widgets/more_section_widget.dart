part of '../imports/view_imports.dart';

class _MoreSectionWidget extends StatelessWidget {
  final String titleKey;
  final List<MoreItemEntity> items;

  const _MoreSectionWidget({required this.titleKey, required this.items});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 4.w, bottom: 10.h),
          child: Text(
            titleKey,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: AppColors.moreSectionTitle,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w, end: 62.w),
              child: const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.moreDivider,
              ),
            ),
            itemBuilder: (context, index) {
              return MoreMenuCardWidget(menuItem: items[index]);
            },
          ),
        ),
      ],
    );
  }
}
