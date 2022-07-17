import 'package:analytics_site/screens/login/login.dart';
import 'package:analytics_site/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginPage', () {
    final emailInputKey = Key('__loginPage_email_textField__');
    final passwordInputKey = Key('__loginPage_password_textField__');
    final loginButtonKey = Key('__loginPage_login_elevatedButton__');

    group('renders', () {
      testWidgets('renders email text input', (tester) async {
        await tester.pumpWidget(MaterialApp(home: LoginPage()));
        expect(find.byKey(emailInputKey), findsOneWidget);
      });

      testWidgets('renders password text input', (tester) async {
        await tester.pumpWidget(MaterialApp(home: LoginPage()));
        expect(find.byKey(passwordInputKey), findsOneWidget);
      });

      testWidgets('renders login button', (tester) async {
        await tester.pumpWidget(MaterialApp(home: LoginPage()));
        expect(find.byKey(loginButtonKey), findsOneWidget);
      });
    });

    testWidgets('login button sends user to main screen when clicked',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      await tester.tap(find.byKey(loginButtonKey));
      await tester.pumpAndSettle();
      expect(find.byType(MainScreen), findsOneWidget);
    });
  });
}
