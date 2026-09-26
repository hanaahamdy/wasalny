import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../core/widgets/navigation_bar/navigation_bar.dart';
import '../../../../core/widgets/navigation_bar/navigation_bar_entity.dart';
import '../../../settings/more/presentation/more_screen.dart';

/// Two-tab shell used by workflow-only roles.
class WorkflowRoleTabsScreen extends StatefulWidget {
  const WorkflowRoleTabsScreen({super.key, required this.home});

  final Widget home;

  @override
  State<WorkflowRoleTabsScreen> createState() => _WorkflowRoleTabsScreenState();
}

class _WorkflowRoleTabsScreenState extends State<WorkflowRoleTabsScreen> {
  int _selectedIndex = 0;

  List<NavigationBarEntity> get _tabs => [
    NavigationBarEntity(
      text: LocaleKeys.home,
      icon: AppAssets.svg.baseSvg.home.path,
    ),
    NavigationBarEntity(
      text: LocaleKeys.more,
      icon: AppAssets.svg.baseSvg.more.path,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [widget.home, const MoreScreen()],
      ),
      bottomNavigationBar: CustomNavigationBar(
        tabs: _tabs,
        selectedIndex: _selectedIndex,
        onTabChange: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
