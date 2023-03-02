import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void expectSnackBarWithMessage(String message) {
  expect(find.byType(SnackBar), findsOneWidget);
  expect(find.text(message), findsOneWidget);
}

void expectButtonEnabled(
  WidgetTester tester,
  Finder finder, {
  required bool isEnabled,
}) {
  final buttonWidget = tester.widget<ButtonStyleButton>(finder);
  expect(buttonWidget.enabled, isEnabled);
}
