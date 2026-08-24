import 'package:flutter/material.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/widgets/navigation_bar/navigation_bar_entity.dart';

class HomeParams {
  HomeParams({int initialIndex = 0})
    : selectedIndexNotifier = ValueNotifier<int>(initialIndex);

  final ValueNotifier<int> selectedIndexNotifier;

  void dispose() => selectedIndexNotifier.dispose();

  void updateNavValue(int value) {
    selectedIndexNotifier.value = value;
    // if (UserCubit.instance.isUserLoggedIn) {
    //   selectedIndexNotifier.value = value;
    // } else {
    //   if (value == 0 || value == 3) {
    //     selectedIndexNotifier.value = value;
    //   } else {
    //     visitorDialog(visitorDesc(value));
    //   }
    // }
  }

  List<NavigationBarEntity> get navTabs => [
    NavigationBarEntity(
      text: LocaleKeys.home,
      icon: AppAssets.svg.baseSvg.home.path,
    ),
    NavigationBarEntity(
      text: LocaleKeys.orders,
      icon: AppAssets.svg.baseSvg.bookingIcon.path,
    ),

    NavigationBarEntity(
      text: LocaleKeys.more,
      icon: AppAssets.svg.baseSvg.more.path,
    ),
  ];
}
