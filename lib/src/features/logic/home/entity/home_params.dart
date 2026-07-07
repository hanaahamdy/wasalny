import 'package:flutter/material.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../../core/widgets/dialogs/visitor_pop_up.dart';
import '../../../../core/widgets/navigation_bar/navigation_bar_entity.dart';

class HomeParams {
  HomeParams({int initialIndex = 0})
    : selectedIndexNotifier = ValueNotifier<int>(initialIndex);

  final ValueNotifier<int> selectedIndexNotifier;

  void dispose() => selectedIndexNotifier.dispose();

  String visitorDesc(int value) {
    switch (value) {
      case 1:
        return LocaleKeys.bookings;
      case 2:
        return LocaleKeys.wallet;
      default:
        return ConstantManager.emptyText;
    }
  }

  void updateNavValue(int value) {
    if (UserCubit.instance.isUserLoggedIn) {
      selectedIndexNotifier.value = value;
    } else {
      if (value == 0 || value == 3) {
        selectedIndexNotifier.value = value;
      } else {
        visitorDialog(visitorDesc(value));
      }
    }
  }

  List<NavigationBarEntity> get navTabs => [
    NavigationBarEntity(
      text: LocaleKeys.home,
      icon: AppAssets.svg.appSvg.home.path,
    ),
    NavigationBarEntity(
      text: LocaleKeys.bookings,
      icon: AppAssets.svg.appSvg.home.path,
    ),
    NavigationBarEntity(
      text: LocaleKeys.wallet,
      icon: AppAssets.svg.appSvg.home.path,
    ),
    NavigationBarEntity(
      text: LocaleKeys.more,
      icon: AppAssets.svg.appSvg.home.path,
    ),
  ];
}
