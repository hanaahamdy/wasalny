import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../logic/home_tabs/more_tab/entity/more_menu_item_entity.dart';
import '../../../language/presentation/widgets/language_picker_sheet.dart';
import '../../profile/presentation/imports/view_imports.dart';

class SettingsItemEntity {
  static List<MoreItemEntity> get generalItems => [
    MoreItemEntity(
      title: LocaleKeys.settingsEditProfile,
      subtitle: LocaleKeys.settingsEditProfileSubtitle,
      image: AppAssets.svg.baseSvg.userSetting,
      iconBackgroundColor: AppColors.settingsProfileIconBackground,
      iconColor: AppColors.primary,
      onTap: () => Go.to(const EditProfileView()),
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsChangePhone,
      subtitle: LocaleKeys.settingsChangePhoneSubtitle,
      image: AppAssets.svg.baseSvg.info,
      iconBackgroundColor: AppColors.moreSettingsIconBackground,
      iconColor: AppColors.settingsPhoneIcon,
      // onTap: () => Go.to(const VerifyPasswordScreen()),
      onTap: () {},
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsLanguages,
      subtitle: LocaleKeys.settingsLanguages,
      image: AppAssets.svg.baseSvg.settingLang,
      iconBackgroundColor: AppColors.settingsLanguageIconBackground,
      iconColor: AppColors.settingsLanguageIcon,
      onTap: () => LanguagePickerSheet.show(Go.context),
    ),
    MoreItemEntity(
      title: LocaleKeys.settingsNotifications,
      subtitle: LocaleKeys.settingsNotificationsAvailable,
      image: AppAssets.svg.baseSvg.notification,
      iconBackgroundColor: AppColors.settingsNotificationsIconBackground,
      iconColor: AppColors.settingsNotificationsIcon,
      useSwitch: true,
      onTap: () {},
    ),
  ];
}
