import 'package:flutter/material.dart';
import '../../../config/res/config_imports.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../core/shared/models/user_model.dart';
import '../../logic/home/presentation/imports/view_imports.dart';
import 'admin_approval_screen.dart';
import 'aliaa_screen.dart';
import 'buyer_screen.dart';
import 'packing_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  final String email;

  const RoleSelectionScreen({super.key, required this.email});

  Future<void> _openExistingCycle(UserType type) async {
    final user = UserModel.initial().copyWith(
      fullName: type == UserType.admin ? 'Admin' : 'Delivery',
      email: email,
      userType: type,
    );
    await UserCubit.instance.setUserLoggedIn(user: user, token: 'mock-role-token');
    Go.offAll(const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final roles = <_RoleData>[
      _RoleData(
        title: 'Admin',
        subtitle: 'Existing admin cycle and buyer approvals',
        icon: Icons.admin_panel_settings_outlined,
        color: const Color(0xFF2563EB),
        onTap: () => _showAdminChoice(context),
      ),
      _RoleData(
        title: 'Delivery',
        subtitle: 'Open the existing delivery cycle',
        icon: Icons.local_shipping_outlined,
        color: const Color(0xFF0F9F8E),
        onTap: () => _openExistingCycle(UserType.delivery),
      ),
      _RoleData(
        title: 'Buyer',
        subtitle: 'Create an order and request Facebook Live',
        icon: Icons.shopping_bag_outlined,
        color: const Color(0xFF7C3AED),
        onTap: () => Go.to(const BuyerScreen()),
      ),
      _RoleData(
        title: 'Packing',
        subtitle: 'Prepare, print, and send orders to Aliaa',
        icon: Icons.inventory_2_outlined,
        color: const Color(0xFFEA8A00),
        onTap: () => Go.to(const PackingScreen()),
      ),
      _RoleData(
        title: 'Aliaa',
        subtitle: 'Add the final client number',
        icon: Icons.contact_phone_outlined,
        color: const Color(0xFFE34D4D),
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
                    gradient: AppColors.buttonGradient,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.route_outlined, size: 34),
                ),
                const SizedBox(height: 20),
                Text(
                  'Choose a test cycle',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.main,
                  ),
                ),
                const SizedBox(height: 6),
                const Text('Select who is using the app. You can return here to test another role.'),
                const SizedBox(height: 24),
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
              Text('Admin', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(sheetContext);
                  _openExistingCycle(UserType.admin);
                },
                icon: const Icon(Icons.dashboard_outlined),
                label: const Text('Open existing admin cycle'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(sheetContext);
                  Go.to(const AdminApprovalScreen());
                },
                icon: const Icon(Icons.approval_outlined),
                label: const Text('Approve buyer requests'),
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
        title: Text(role.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(role.subtitle),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.hintText, size: 17),
      ),
    );
  }
}
