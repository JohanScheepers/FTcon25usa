// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the
// widget tree, read text, and verify that the values of widget properties are
// correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercon_countdown/src/app.dart';
import 'package:fluttercon_countdown/src/utils/app_constants.dart';

void main() {
  testWidgets('Countdown app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FlutterconCountdownApp());

    // Verify that the app title is displayed.
    expect(find.text(kAppTitle), findsOneWidget);
    // Verify that the countdown introductory text is present.
    // This might change if the event has passed, so this is a basic check.
    expect(find.text('Countdown to Fluttercon USA 2025'), findsOneWidget);
  });
}
