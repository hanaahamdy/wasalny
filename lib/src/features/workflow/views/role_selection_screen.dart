import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/res/config_imports.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../core/shared/models/user_model.dart';
import '../../logic/home/presentation/imports/view_imports.dart';
import '../../users_type/aliaa/views/aliaa_screen.dart';
import '../../users_type/buyer/views/buyer_screen.dart';
import '../../users_type/packing/views/packing_screen.dart';
import 'admin_approval_screen.dart';
import '../../../config/language/locale_keys.g.dart';

/// Entry view used to select a workflow role during the test cycle.
class RoleSelectionScreen extends StatefulWidget {
  final String email;

  const RoleSelectionScreen({super.key, required this.email});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  Future<void> _openExistingCycle(UserType type) async {
    final user = UserModel.initial().copyWith(
      fullName: type == UserType.admin ? 'Admin' : 'Delivery',
      email: widget.email,
      userType: type,
    );
    await UserCubit.instance.setUserLoggedIn(
      user: user,
      token: 'mock-role-token',
    );
    Go.offAll(const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final roles = <_RoleData>[
      _RoleData(
        title: LocaleKeys.workflowAdmin,
        subtitle: LocaleKeys.workflowAdminSubtitle,
        icon: Icons.admin_panel_settings_outlined,
        color: AppColors.scenarioPrimary,
        onTap: () => _showAdminChoice(context),
      ),
      _RoleData(
        title: LocaleKeys.workflowDelivery,
        subtitle: LocaleKeys.workflowDeliverySubtitle,
        icon: Icons.local_shipping_outlined,
        color: AppColors.scenarioPrimary,
        onTap: () => _openExistingCycle(UserType.delivery),
      ),
      _RoleData(
        title: LocaleKeys.workflowBuyer,
        subtitle: LocaleKeys.workflowBuyerSubtitle,
        icon: Icons.shopping_bag_outlined,
        color: AppColors.scenarioPrimary,
        onTap: () => Go.to(const BuyerScreen()),
      ),
      _RoleData(
        title: LocaleKeys.workflowPacking,
        subtitle: LocaleKeys.workflowPackingSubtitle,
        icon: Icons.inventory_2_outlined,
        color: AppColors.scenarioPrimary,
        onTap: () => Go.to(const PackingScreen()),
      ),
      _RoleData(
        title: LocaleKeys.workflowAliaa,
        subtitle: LocaleKeys.workflowAliaaSubtitle,
        icon: Icons.contact_phone_outlined,
        color: AppColors.scenarioPrimary,
        onTap: () => Go.to(const AliaaScreen()),
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: AppColors.scenarioGradient,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.route_outlined, size: 34),
                ),
                const SizedBox(height: 20),
                Text(
                  LocaleKeys.workflowChooseTestCycle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.main,
                  ),
                ),
                const SizedBox(height: 6),
                Text(LocaleKeys.workflowSelectRoleNotice),
                const SizedBox(height: 24),
                RadioGroup<AppColorScenario>(
                  groupValue: AppColors.selectedScenario,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => AppColors.selectedScenario = value);
                    SystemChrome.setSystemUIOverlayStyle(
                      AppColors.systemUiOverlayStyle,
                    );
                  },
                  child: Column(
                    children: [
                      RadioListTile<AppColorScenario>(
                        value: AppColorScenario.first,
                        activeColor: AppColors.scenarioPrimary,
                        title: Text(LocaleKeys.workflowFirstScenario),
                      ),
                      RadioListTile<AppColorScenario>(
                        value: AppColorScenario.second,
                        activeColor: AppColors.scenarioPrimary,
                        title: Text(LocaleKeys.workflowSecondScenario),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ...roles.map((role) => _RoleCard(role: role)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAdminChoice(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                LocaleKeys.workflowAdmin,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.scenarioPrimary,
                ),
                onPressed: () {
                  Navigator.pop(sheetContext);
                  _openExistingCycle(UserType.admin);
                },
                icon: const Icon(Icons.dashboard_outlined),
                label: Text(LocaleKeys.workflowOpenAdminCycle),
              ),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.scenarioPrimary,
                  side: BorderSide(color: AppColors.scenarioPrimary),
                ),
                onPressed: () {
                  Navigator.pop(sheetContext);
                  Go.to(const AdminApprovalScreen());
                },
                icon: const Icon(Icons.approval_outlined),
                label: Text(LocaleKeys.workflowApproveBuyerRequests),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RoleData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class _RoleCard extends StatelessWidget {
  final _RoleData role;
  const _RoleCard({required this.role});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        onTap: role.onTap,
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: role.color.withValues(alpha: .12),
          child: Icon(role.icon, color: role.color),
        ),
        title: Text(
          role.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(role.subtitle),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.hintText,
          size: 17,
        ),
      ),
    );
  }
}
