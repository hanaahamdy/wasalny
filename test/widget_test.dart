import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterbase/src/features/logic/home_tabs/stadiums/presentation/stadiums_feature.dart';

void main() {
  testWidgets('stadiums home renders fake API content', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return const MaterialApp(home: StadiumsHomeView());
        },
      ),
    );

    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('الرياضات المتاحة'), findsOneWidget);
    expect(find.text('الملاعب المميزة'), findsOneWidget);
    expect(find.text('ملعب النخيل الرياضي'), findsOneWidget);
  });
}
