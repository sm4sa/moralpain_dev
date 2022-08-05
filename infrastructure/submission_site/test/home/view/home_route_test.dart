import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/api_repository.dart';
import 'package:submission_site/home/home.dart';

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  late ApiRepository repository;

  setUp(() {
    repository = MockApiRepository();

    final builder = SubmissionBuilder();
    builder.id = '119ada26-a0ba-4991-82f4-d6aa7c73c503';
    builder.score = 4;
    builder.timestamp = 1658944322;
    builder.selections = ListBuilder(['001_02', '001_03', '002_02', '004_06']);
    when(() => repository.fetchSubmission(any()))
        .thenAnswer((_) => Future.value(builder.build()));
  });

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: HomeRoute(
          repository: repository,
        ),
      ),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('renders HomeView', (tester) async {
    await pumpApp(tester);
    expect(find.byType(HomeView), findsOneWidget);
  });

  testWidgets('fetches submission and survey on initialization',
      (tester) async {
    await tester.runAsync(() async {
      await pumpApp(tester);
      verify(() => repository.fetchSubmission(any())).called(1);
      verify(() => repository.fetchSurvey()).called(1);
    });
  });
}
