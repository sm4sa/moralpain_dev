import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moraldistress/thermometer/thermometer.dart';
import 'package:moraldistress/thermometer/view/thermometer_view.dart';

void main() {
  group('ThermometerRoute', () {
    testWidgets('renders ThermometerView', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ThermometerRoute(),
      ));
      expect(find.byType(ThermometerView), findsOneWidget);
    });
  });
}
