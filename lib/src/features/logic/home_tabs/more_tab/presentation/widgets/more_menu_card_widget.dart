import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/language/locale_keys.g.dart';
import '../../../../../../config/res/config_imports.dart';
import '../../../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../../../core/extensions/widgets/widget_extension.dart';
import '../../../../../../core/navigation/navigator.dart';
import '../../../../../settings/profile/presentation/imports/view_imports.dart';
import '../../entity/more_menu_item_entity.dart';

class MoreMenuCardWidget extends StatelessWidget {
  final MoreItemEntity menuItem;
  final bool showDivider;
  final EdgeInsetsGeometry? padding;

  const MoreMenuCardWidget({
    super.key,
    required this.menuItem,
    this.showDivider = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;
    final onTap = menuItem.title == LocaleKeys.profile
        ? () => Go.to(const ProfileView())
        : menuItem.onTap;

    return Container(
      height: 67.h,
      padding: padding,
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(color: AppColors.moreDivider, width: 1.h),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _MoreMenuIcon(menuItem: menuItem),
          12.szW,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuItem.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (menuItem.subtitle.isNotEmpty) ...[
                  SizedBox(height: 5.h),
                  Text(
                    menuItem.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.hintText,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
          _MoreMenuTrailing(menuItem: menuItem),
        ],
      ),
    ).onClick(onTap: menuItem.useSwitch ? null : onTap);
  }
}

class _MoreMenuIcon extends StatelessWidget {
  final MoreItemEntity menuItem;

  const _MoreMenuIcon({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.r,
      height: 36.r,
      decoration: BoxDecoration(
        color: menuItem.iconBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: menuItem.image.svg(
          width: 19.r,
          height: 19.r,
          colorFilter: ColorFilter.mode(menuItem.iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class _MoreMenuTrailing extends StatelessWidget {
  final MoreItemEntity menuItem;

  const _MoreMenuTrailing({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    if (menuItem.useSwitch) {
      return Switch(
        value: true,
        activeColor: AppColors.white,
        activeTrackColor: AppColors.primary,
        inactiveThumbColor: AppColors.white,
        inactiveTrackColor: AppColors.border,
        onChanged: (_) {},
      );
    }

    if (menuItem.disableArrow) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsetsDirectional.only(start: 14.w),
      child: Icon(Icons.chevron_right, color: AppColors.border, size: 22.r),
    );
  }
}
