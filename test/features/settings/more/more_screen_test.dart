import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterbase/src/config/language/locale_keys.g.dart';
import 'package:flutterbase/src/config/res/config_imports.dart';
import 'package:flutterbase/src/core/navigation/navigator.dart';
import 'package:flutterbase/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:flutterbase/src/core/shared/models/user_model.dart';
import 'package:flutterbase/src/core/shared/service_locators/setup_service_locators.dart';
import 'package:flutterbase/src/features/auth/presentation/imports/view_imports.dart';
import 'package:flutterbase/src/features/settings/more/presentation/more_screen.dart';
import 'package:flutterbase/src/features/users_type/buyer/views/buyer_screen.dart';

void main() {
  setUpAll(setUpServiceLocator);

  for (final role in [UserRole.admin, UserRole.delivery]) {
    testWidgets('shows one reset-flow change password item for ${role.name}', (
      tester,
    ) async {
      final userCubit = UserCubit();
      userCubit.emit(
        UserState(
          userModel: UserModel.initial().copyWith(role: role),
          userStatus: UserStatus.loggedIn,
        ),
      );
      await injector.unregister<UserCubit>();
      injector.registerSingleton<UserCubit>(userCubit);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (_, _) => const MaterialApp(home: MoreScreen()),
        ),
      );

      final changePasswordItem = find.text(LocaleKeys.changePassword);
      expect(changePasswordItem, findsOneWidget);

      await tester.tap(changePasswordItem);
      await tester.pumpAndSettle();

      expect(find.byType(ForgotPasswordScreen), findsOneWidget);
    });
  }

  testWidgets('opens the live flow from the admin More screen', (tester) async {
    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final userCubit = UserCubit();
    userCubit.emit(
      UserState(
        userModel: UserModel.initial().copyWith(role: UserRole.admin),
        userStatus: UserStatus.loggedIn,
      ),
    );
    await injector.unregister<UserCubit>();
    injector.registerSingleton<UserCubit>(userCubit);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (_, _) => MaterialApp(
          navigatorKey: Go.navigatorKey,
          theme: ThemeData(splashFactory: NoSplash.splashFactory),
          home: const Scaffold(body: MoreScreen()),
        ),
      ),
    );

    await tester.tap(find.text(LocaleKeys.liveBroadcast));
    await tester.pumpAndSettle();

    expect(find.byType(BuyerLiveRequestScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
