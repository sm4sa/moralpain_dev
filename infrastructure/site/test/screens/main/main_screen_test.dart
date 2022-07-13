import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('MainScreen', () {
    testWidgets('renders DashboardScreen', (tester) async {
      await pumpApp(tester);
      await tester.pump();
      expect(find.byType(DashboardScreen), findsOneWidget);
    });

    testWidgets('doesn\'t render SideMenu if the window isn\'t wide enough',
        (tester) async {
      await pumpApp(tester);
      await tester.pump();
      expect(find.byType(SideMenu), findsNothing);
    });

    testWidgets('renders SideMenu if window is wide enough', (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(3840, 2160);

      // resets the screen to its original size after the test ends
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await pumpApp(tester);
      await tester.pump();
      expect(find.byType(SideMenu), findsOneWidget);
    });
  });
}

Future<void> pumpApp(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: MainScreen(),
      ),
    ),
  );
}
