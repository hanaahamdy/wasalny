import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterbase/src/core/shared/service_locators/setup_service_locators.dart';
import 'package:flutterbase/src/features/logic/home_tabs/main_tab_screen/presentation/imports/main_tab_screen_imports.dart';

void main() {
  setUpAll(setUpServiceLocator);

  testWidgets('main tab screen renders', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return const MaterialApp(home: MainTabScreen());
        },
      ),
    );

    expect(find.byType(MainTabScreen), findsOneWidget);
  });
}
