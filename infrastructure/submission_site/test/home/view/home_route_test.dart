import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission_site/api_repository.dart';
import 'package:submission_site/home/home.dart';

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  late ApiRepository repository;

  setUp(() => repository = MockApiRepository());

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: HomeRoute(),
      ),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('renders HomeView', (tester) async {
    await pumpApp(tester);
    expect(find.byType(HomeView), findsOneWidget);
  });
}
