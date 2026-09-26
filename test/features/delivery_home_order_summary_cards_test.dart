import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterbase/src/core/shared/models/request_state.dart';
import 'package:flutterbase/src/core/shared/service_locators/setup_service_locators.dart';
import 'package:flutterbase/src/features/logic/home_tabs/delivery/delivery_home/entity/delivery_home_model.dart';
import 'package:flutterbase/src/features/logic/home_tabs/delivery/delivery_home/presentation/cubits/delivery_home_cubit.dart';
import 'package:flutterbase/src/features/logic/home_tabs/delivery/delivery_home/presentation/imports/presentation_imports.dart';

void main() {
  setUpAll(setUpServiceLocator);

  testWidgets('summary cards use the admin reference order icons', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 690);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final cubit = DeliveryHomeCubit();
    cubit.emit(
      const RequestState(
        data: DeliveryHomeModel(
          createdOrders: 2,
          deliveredOrders: 2,
          latestOrders: [],
        ),
      ),
    );
    addTearDown(cubit.close);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: cubit,
              child: const SizedBox(
                height: 160,
                child: DeliveryHomeOrderSummaryCards(),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.inventory_2_outlined), findsOneWidget);
    expect(find.byIcon(Icons.task_alt), findsOneWidget);
    expect(find.byIcon(Icons.calculate_rounded), findsNothing);
    expect(find.byIcon(Icons.check_circle_outline), findsNothing);
  });
}
