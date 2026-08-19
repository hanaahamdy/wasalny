import 'package:flutter/material.dart';
import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../settings/contact_us/presentation/imports/contact_us_imports.dart';
import '../../../../settings/settings/presentation/imports/view_imports.dart';
import '../../../../settings/static_pages/entity/static_pages_enum.dart';
import '../../../../settings/static_pages/presentation/imports/view_imports.dart';
import '../../../../settings/team/presentation/imports/view_imports.dart';

class MoreItemEntity {
  final String title;
  final String subtitle;
  final SvgGenImage image;
  final Color iconBackgroundColor;
  final Color iconColor;
  final VoidCallback onTap;
  final bool disableArrow;
  final bool useSwitch;

  MoreItemEntity({
    required this.title,
    this.subtitle = '',
    required this.image,
    this.iconBackgroundColor = AppColors.fieldFillColor,
    this.iconColor = AppColors.primary,
    required this.onTap,
    this.disableArrow = false,
    this.useSwitch = false,
  });

  static List<MoreItemEntity> get generalItems => [
    MoreItemEntity(
      title: LocaleKeys.profile,
      subtitle: LocaleKeys.moreProfileSubtitle,
      image: AppAssets.svg.baseSvg.userSetting,
      iconBackgroundColor: AppColors.moreProfileIconBackground,
      iconColor: AppColors.authTabSelected,
      onTap: () {},
    ),
    MoreItemEntity(
      title: LocaleKeys.moreGeneralSettings,
      subtitle: LocaleKeys.moreGeneralSettingsSubtitle,
      image: AppAssets.svg.baseSvg.info,
      iconBackgroundColor: AppColors.moreSettingsIconBackground,
      iconColor: AppColors.primary,
      onTap: () => Go.to(const SettingsScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.moreMyTeam,
      subtitle: LocaleKeys.moreMyTeamSubtitle,
      image: AppAssets.svg.baseSvg.celebrate,
      iconBackgroundColor: AppColors.moreTeamIconBackground,
      iconColor: AppColors.bookingPendingYellow,
      onTap: () => Go.to(const TeamTabView()),
    ),
  ];

  /// Others section menu items
  static List<MoreItemEntity> get otherItems => [
    MoreItemEntity(
      title: LocaleKeys.contactUs,
      subtitle: LocaleKeys.moreContactSubtitle,
      image: AppAssets.svg.baseSvg.call,
      iconBackgroundColor: AppColors.moreContactIconBackground,
      iconColor: AppColors.primary,
      onTap: () => Go.to(const ContactUsScreen()),
    ),
    MoreItemEntity(
      title: LocaleKeys.moreTermsPrivacy,
      subtitle: LocaleKeys.moreTermsPrivacySubtitle,
      image: AppAssets.svg.baseSvg.calednder,
      iconBackgroundColor: AppColors.moreTermsIconBackground,
      iconColor: AppColors.bookingPendingYellow,
      onTap: () => Go.to(
        const StaticPagesScreen(
          pageType: StaticPageTypeEnum.termsAndConditions,
        ),
      ),
    ),
    MoreItemEntity(
      title: LocaleKeys.moreAboutUs,
      subtitle: LocaleKeys.moreAboutUsSubtitle,
      image: AppAssets.svg.baseSvg.calednder,
      iconBackgroundColor: AppColors.moreTermsIconBackground,
      iconColor: AppColors.bookingPendingYellow,
      onTap: () => Go.to(
        const StaticPagesScreen(pageType: StaticPageTypeEnum.aboutRita),
      ),
    ),
  ];

  /// Others section menu items
  static List<MoreItemEntity> get guestItems => [
    MoreItemEntity(
      title: LocaleKeys.whoUs,
      subtitle: LocaleKeys.moreAboutUsSubtitle,
      image: AppAssets.svg.baseSvg.info,
      iconBackgroundColor: AppColors.moreTermsIconBackground,
      iconColor: AppColors.bookingPendingYellow,
      onTap: () => Go.to(
        const StaticPagesScreen(pageType: StaticPageTypeEnum.aboutRita),
      ),
    ),
    MoreItemEntity(
      title: LocaleKeys.contactUs,
      subtitle: LocaleKeys.moreContactSubtitle,
      image: AppAssets.svg.baseSvg.call,
      iconBackgroundColor: AppColors.moreContactIconBackground,
      iconColor: AppColors.primary,
      onTap: () => Go.to(const ContactUsScreen()),
    ),

    MoreItemEntity(
      title: LocaleKeys.terms,
      subtitle: LocaleKeys.moreTermsPrivacySubtitle,
      image: AppAssets.svg.baseSvg.policyIcon,
      iconBackgroundColor: AppColors.moreTermsIconBackground,
      iconColor: AppColors.bookingPendingYellow,
      onTap: () => Go.to(
        const StaticPagesScreen(
          pageType: StaticPageTypeEnum.termsAndConditions,
        ),
      ),
    ),
    MoreItemEntity(
      title: LocaleKeys.policy,
      subtitle: LocaleKeys.moreTermsPrivacySubtitle,
      image: AppAssets.svg.baseSvg.policyIcon,
      iconBackgroundColor: AppColors.moreTermsIconBackground,
      iconColor: AppColors.bookingPendingYellow,
      onTap: () => Go.to(
        const StaticPagesScreen(pageType: StaticPageTypeEnum.usagePolicy),
      ),
    ),

    MoreItemEntity(
      title: LocaleKeys.logout,
      subtitle: ConstantManager.emptyText,
      image: AppAssets.svg.baseSvg.replaceIcon,
      iconBackgroundColor: AppColors.moreLogoutBackground,
      iconColor: AppColors.moreLogoutText,
      disableArrow: true,
      onTap: () {},
    ),
  ];
}
