import 'package:flutter/material.dart';
import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../home/presentation/imports/view_imports.dart';

class ViewAllOrdersWidget extends StatelessWidget {
  final String title;
  const ViewAllOrdersWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.main,
            fontSize: FontSizeManager.s13,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () =>Go.to(const HomeScreen(initialTabIndex: 1)),
          child: Text(
            LocaleKeys.viewAll,
            style: TextStyle(
              color: AppColors.authTabSelected,
              fontSize: FontSizeManager.s11,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ),
      ],
    );
  }
}
