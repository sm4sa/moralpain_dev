import 'package:submissions_site/controllers/MenuController.dart';
import 'package:submissions_site/screens/dashboard/components/header.dart';
import 'package:submissions_site/screens/submissions/submissions.dart';
import 'package:submissions_site/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('DashboardScreen', () {
    group('renders', () {
      testWidgets('Header', (tester) async {
        await buildApp(tester);
        expect(find.byType(Header), findsOneWidget);
      });

      testWidgets('SubmissionsRoute', (tester) async {
        await buildApp(tester);
        expect(find.byType(SubmissionsRoute), findsOneWidget);
      });

      testWidgets('SubmissionsView', (tester) async {
        await buildApp(tester);
        expect(find.byType(SubmissionsView), findsOneWidget);
      });
    });
  });
}

Future<void> buildApp(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => MenuController(),
          ),
        ],
        child: Scaffold(
          body: DashboardScreen(),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
