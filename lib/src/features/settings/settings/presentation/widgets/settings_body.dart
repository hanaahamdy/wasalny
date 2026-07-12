part of '../imports/view_imports.dart';

class _SettingsTabBody extends StatelessWidget {
  const _SettingsTabBody();

  @override
  Widget build(BuildContext context) {
    context.locale;
    final generalItems = SettingsItemEntity.generalItems;
    return ListView(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 28.h),
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: .07),
                blurRadius: 54.r,
              ),
            ],
          ),
          child: Column(
            children: List.generate(generalItems.length, (index) {
              final menuItem = generalItems[index];
              return MoreMenuCardWidget(
                menuItem: menuItem.title == LocaleKeys.settingsChangePhone
                    ? MoreItemEntity(
                        title: menuItem.title,
                        subtitle: menuItem.subtitle,
                        icon: menuItem.icon,
                        iconData: menuItem.iconData,
                        iconBackgroundColor: menuItem.iconBackgroundColor,
                        iconColor: menuItem.iconColor,
                        disableArrow: menuItem.disableArrow,
                        useSwitch: menuItem.useSwitch,
                        onTap: () =>
                            showChangePhoneBottomSheet(context: context),
                      )
                    : menuItem,
                showDivider: index != generalItems.length - 1,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              );
            }),
          ),
        ),
      ],
    );
  }
}
