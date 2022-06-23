import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('MainScreen', () {
    testWidgets('renders DashboardScreen', (tester) async {
      await tester.pumpWidget(MainScreen());
      await tester.pump();
      expect(find.byType(DashboardScreen), findsOneWidget);
    });
  });
}
