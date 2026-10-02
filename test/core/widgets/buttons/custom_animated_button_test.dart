import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterbase/src/core/widgets/buttons/custom_animated_button.dart';

void main() {
  testWidgets('does not use its controller after being disposed', (
    tester,
  ) async {
    final pendingAction = Completer<void>();

    await tester.pumpWidget(
      MaterialApp(
        home: CustomAnimatedButton(
          height: 48,
          width: 200,
          color: Colors.blue,
          loader: const CircularProgressIndicator(),
          onTap: () => pendingAction.future,
          child: const Text('Submit'),
        ),
      ),
    );

    await tester.tap(find.text('Submit'));
    await tester.pump();
    await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));

    pendingAction.complete();
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
