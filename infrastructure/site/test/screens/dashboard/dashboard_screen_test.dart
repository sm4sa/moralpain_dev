import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/recent_reports.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
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

      testWidgets('RecentReports', (tester) async {
        await buildApp(tester);
        expect(find.byType(RecentReports), findsOneWidget);
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
            create: (context) => MenuController(),
          ),
        ],
        child: Scaffold(
          body: DashboardScreen(),
        ),
      ),
    ),
  );
}
