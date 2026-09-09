import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/res/config_imports.dart';
import 'navigation_bar_entity.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
    required this.tabs,
    this.selectedIndex = 0,
    this.onTabChange,
  });

  final List<NavigationBarEntity> tabs;
  final int selectedIndex;
  final ValueChanged<int>? onTabChange;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late int _selectedIndex;
  bool _isClickable = true;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(CustomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _selectedIndex = widget.selectedIndex;
    }
  }

  void _handleTabPress(int index) {
    if (!_isClickable) return;

    setState(() {
      _selectedIndex = index;
      _isClickable = false;
    });

    widget.onTabChange?.call(index);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isClickable = true);
      }
    });
  }

  Widget _buildTab(NavigationBarEntity tab, int index) {
    context.locale;
    final isActive = _selectedIndex == index;
    final color = isActive
        ? AppColors.scenarioPrimary
        : AppColors.scenarioMuted;

    return Expanded(
      child: Semantics(
        selected: isActive,
        button: true,
        label: tab.text,
        child: InkWell(
          onTap: () => _handleTabPress(index),
          child: SizedBox(
            height: AppSize.sH60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  tab.icon,
                  width: AppSize.sH22,
                  height: AppSize.sH22,
                  // ignore: deprecated_member_use
                  color: color,
                ),
                SizedBox(height: AppSize.sH6),
                Text(
                  tab.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: color,
                    fontSize: FontSizeManager.s12,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Container(
      height: AppSize.sH85,
      padding: EdgeInsets.fromLTRB(
        AppPadding.pW8,
        AppPadding.pH8,
        AppPadding.pW8,
        AppPadding.pH10,
      ),
      decoration: BoxDecoration(
        color: AppColors.scenarioSurface,
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 15,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.tabs
            .asMap()
            .entries
            .map((entry) => _buildTab(entry.value, entry.key))
            .toList(),
      ),
    );
  }
}
