// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_security_workforce/main.dart';

void main() {
  testWidgets('MyApp builds without throwing', (WidgetTester tester) async {
    // Prevent SplashPageController from reading real storage in tests.
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MyApp());

    // Allow SplashPageController delayed navigation to complete,
    // otherwise Flutter test framework fails due to pending timers.
    await tester.pump(const Duration(seconds: 3));

    // If GetMaterialApp builds, the route/navigation setup succeeded.
    expect(find.byType(GetMaterialApp), findsOneWidget);

    // No framework exception should have been thrown during the last pump.
    expect(tester.takeException(), isNull);
  });
}
