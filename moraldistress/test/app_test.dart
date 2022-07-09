import 'package:flutter_test/flutter_test.dart';
import 'package:moraldistress/app.dart';
import 'package:moraldistress/home/home.dart';

void main() {
  group('MoralDistressApp', () {
    testWidgets('renders HomeRoute', (tester) async {
      await tester.pumpWidget(const MoralDistressApp());
      expect(find.byType(HomeRoute), findsOneWidget);
    });
  });
}
