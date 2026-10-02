import 'package:flutter/material.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../../core/shared/models/user_model.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../auth/presentation/imports/view_imports.dart';
import '../../../language/presentation/widgets/language_picker_sheet.dart';
import '../../../users_type/admin/views/admin_live_requests_screen.dart';
import '../../admin_sales/presentation/imports/presentation_imports.dart';
import '../../customers/presentation/imports/presentation_imports.dart';
import '../../employees/presentation/imports/presentation_imports.dart';
import '../../profile/presentation/imports/view_imports.dart';
import '../../static_pages/entity/static_pages_enum.dart';
import '../../static_pages/presentation/imports/view_imports.dart';
import '../../total_deliveries/presentation/imports/presentation_imports.dart';

part 'widgets/delivery_profile_card.dart';
part 'widgets/logout_dialog.dart';
part 'widgets/more_item.dart';
part 'widgets/more_section.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  static Future<void> showLogoutDialog(BuildContext context) =>
      _LogoutDialog.show(context);

  @override
  Widget build(BuildContext context) {
    final user = UserCubit.instance.user;

    return ColoredBox(
      color: AppColors.scenarioBackground,
      child: Column(
        children: [
          CustomAppBar(
            automaticallyImplyLeading: false,
            title: LocaleKeys.more,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW8,
                vertical: AppPadding.pH12,
              ),
              children: switch (user.role) {
                UserRole.admin => _adminSections(context),
                UserRole.delivery => _deliverySections(
                  context,
                  user,
                  showProfileActions: false,
                ),
                UserRole.packing ||
                UserRole.aliaa => _workflowSections(context),
                UserRole.buyer => _deliverySections(
                  context,
                  user,
                  showProfileActions: true,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _adminSections(BuildContext context) => [
    _MoreSection(
      title: LocaleKeys.moreManagement,
      items: [
        _MoreItem(
          title: LocaleKeys.customers,
          icon: Icons.people_outline,
          onTap: () => Go.to(const CustomersScreen()),
        ),
        _MoreItem(
          title: LocaleKeys.employees,
          icon: Icons.badge_outlined,
          onTap: () => Go.to(const EmployeeTypeScreen()),
        ),
        _MoreItem(
          title: LocaleKeys.sales,
          icon: Icons.attach_money,
          onTap: () => Go.to(const AdminSalesScreen()),
        ),
        _MoreItem(
          title: LocaleKeys.liveBroadcast,
          icon: Icons.videocam_outlined,
          onTap: () => Go.to(const AdminLiveRequestsScreen()),
        ),
      ],
    ),
    _MoreSection(
      title: LocaleKeys.moreAccountAndSettings,
      items: [
        _MoreItem(
          title: LocaleKeys.language,
          icon: Icons.language,
          onTap: () => LanguagePickerSheet.show(context),
        ),
        _MoreItem(
          title: LocaleKeys.changePassword,
          icon: Icons.lock_reset_outlined,
          onTap: () => showChangePasswordBottomSheet(context: context),
        ),
      ],
    ),
    _legalSection(context),
    _logoutSection(context),
  ];

  List<Widget> _deliverySections(
    BuildContext context,
    UserModel user, {
    required bool showProfileActions,
  }) => [
    _DeliveryProfileCard(user: user),
    SizedBox(height: AppSize.sH12),
    _MoreSection(
      items: [
        if (showProfileActions) ...[
          _MoreItem(
            title: LocaleKeys.editProfile,
            icon: Icons.edit_outlined,
            onTap: () => Go.to(const ProfileView()),
          ),
          _MoreItem(
            title: LocaleKeys.changePassword,
            icon: Icons.lock_reset_outlined,
            onTap: () => showChangePasswordBottomSheet(context: context),
          ),
        ],
        _MoreItem(
          title: LocaleKeys.language,
          icon: Icons.language,
          onTap: () => LanguagePickerSheet.show(context),
        ),
        _MoreItem(
          title: LocaleKeys.myDeliveries,
          icon: Icons.local_shipping_outlined,
          onTap: () => Go.to(const TotalDeliveriesScreen()),
        ),
        _MoreItem(
          title: LocaleKeys.privacyPolicy,
          icon: Icons.shield_outlined,
          onTap: () => Go.to(
            const StaticPagesScreen(pageType: StaticPageTypeEnum.usagePolicy),
          ),
        ),
        _MoreItem(
          title: LocaleKeys.terms,
          icon: Icons.description_outlined,
          onTap: () => Go.to(
            const StaticPagesScreen(
              pageType: StaticPageTypeEnum.termsAndConditions,
            ),
          ),
        ),
      ],
    ),
    _logoutSection(context),
  ];

  List<Widget> _workflowSections(BuildContext context) => [
    _legalSection(context),
    _logoutSection(context),
  ];

  Widget _legalSection(BuildContext context) => _MoreSection(
    title: LocaleKeys.moreLegal,
    items: [
      _MoreItem(
        title: LocaleKeys.privacyPolicy,
        icon: Icons.shield_outlined,
        onTap: () => Go.to(
          const StaticPagesScreen(pageType: StaticPageTypeEnum.usagePolicy),
        ),
      ),
      _MoreItem(
        title: LocaleKeys.terms,
        icon: Icons.description_outlined,
        onTap: () => Go.to(
          const StaticPagesScreen(
            pageType: StaticPageTypeEnum.termsAndConditions,
          ),
        ),
      ),
    ],
  );

  Widget _logoutSection(BuildContext context) => _MoreSection(
    items: [
      _MoreItem(
        title: LocaleKeys.logout,
        icon: Icons.logout,
        isDestructive: true,
        onTap: () => showLogoutDialog(context),
      ),
    ],
  );
}
