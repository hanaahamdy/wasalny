import 'package:flutter/material.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../logic/home_tabs/more_tab/entity/more_menu_item_entity.dart';
import '../../profile/presentation/imports/view_imports.dart';

class SettingsItemEntity {
  static List<MoreItemEntity> get generalItems => [
    MoreItemEntity(
      title: LocaleKeys.settingsEditProfile,
      subtitle: LocaleKeys.settingsEditProfileSubtitle,
      icon: AppAssets.svg.baseSvg.profile.path,
      iconData: Icons.person_add_alt_1_outlined,
      iconBackgroundColor: AppColors.settingsProfileIconBackground,
      iconColor: AppColors.primary,
      onTap: () => Go.to(const EditProfileView()),
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsChangePhone,
      subtitle: LocaleKeys.settingsChangePhoneSubtitle,
      icon: AppAssets.svg.baseSvg.changeEmail.path,
      iconData: Icons.shield_outlined,
      iconBackgroundColor: AppColors.moreSettingsIconBackground,
      iconColor: AppColors.settingsPhoneIcon,
      // onTap: () => Go.to(const VerifyPasswordScreen()),
      onTap: () {},
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsLanguages,
      subtitle: LocaleKeys.settingsLanguages,
      icon: AppAssets.svg.baseSvg.changePass.path,
      iconData: Icons.shield_rounded,
      iconBackgroundColor: AppColors.settingsLanguageIconBackground,
      iconColor: AppColors.settingsLanguageIcon,
      onTap: () {},
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsNotifications,
      subtitle: LocaleKeys.settingsNotificationsAvailable,
      icon: AppAssets.svg.baseSvg.notify.path,
      iconData: Icons.notifications_none_rounded,
      iconBackgroundColor: AppColors.settingsNotificationsIconBackground,
      iconColor: AppColors.settingsNotificationsIcon,
      useSwitch: true,
      onTap: () {},
    ),
  ];
}
