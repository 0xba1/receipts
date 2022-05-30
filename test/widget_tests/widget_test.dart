// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:receipts/base/views/screens/login.dart';
import 'package:receipts/base/views/screens/signup.dart';

void main() {
  group('Login Page', () {
    testWidgets(
      'Clicking text button on login page leads to sign up page',
      (WidgetTester tester) async {
        await tester.pumpWidget(const LogInScreen());
        await tester.tap(find.byType(TextButton));
        await tester.pump();

        expect(find.byType(SignUpScreen), findsOneWidget);
      },
    );
  });
  group('Sign Up Page', () {
    testWidgets(
      'Clicking text button on sign up page leads to login page',
      (WidgetTester tester) async {
        await tester.pumpWidget(const SignUpScreen());
        await tester.tap(find.byType(TextButton));
        await tester.pump();

        expect(find.byType(LogInScreen), findsOneWidget);
      },
    );
  });
  // group('Home Page', () {
  //   testWidgets(
  //     'Clicking floating action button leads to the create new receipt page',
  //     (WidgetTester tester) async {
  //       await tester.pumpWidget(const Home());
  //       await tester.tap(find.byType(FloatingActionButton));
  //       await tester.pump();

  //       expect(find.byType(NewReceipt), findsOneWidget);
  //     },
  //   );
  // });
}
