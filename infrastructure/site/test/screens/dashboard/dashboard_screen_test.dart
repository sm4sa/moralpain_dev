import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/analytics0/analytics.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/side_menu/side_menu.dart';
import 'package:admin/screens/submissions/submissions.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        expect(find.byType(AnalyticsView), findsNothing);
      });

      testWidgets(
        'AnalyticsView if SideMenu state is ANALYTICS',
        (tester) async {
          await buildApp(
            tester,
            SideMenuCubit()..setView(DashboardView.ANALYTICS),
          );
          expect(find.byType(AnalyticsView), findsOneWidget);
          expect(find.byType(SubmissionsView), findsNothing);
        },
      );
    });
  });
}

Future<void> buildApp(WidgetTester tester, [SideMenuCubit? cubit]) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => MenuController(),
          ),
          BlocProvider<SideMenuCubit>(
            create: (_) => cubit ?? SideMenuCubit(),
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
