import 'package:analytics_site/controllers/MenuController.dart';
import 'package:analytics_site/screens/analytics0/analytics.dart';
import 'package:analytics_site/screens/dashboard/components/header.dart';
import 'package:analytics_site/screens/dashboard/dashboard_screen.dart';
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

      testWidgets('AnalyticsRoute', (tester) async {
        await buildApp(tester);
        expect(find.byType(AnalyticsRoute), findsOneWidget);
      });

      testWidgets('AnalyticsView', (tester) async {
        await buildApp(tester);
        expect(find.byType(AnalyticsView), findsOneWidget);
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
