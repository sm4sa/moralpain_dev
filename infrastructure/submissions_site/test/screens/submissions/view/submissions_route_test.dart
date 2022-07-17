import 'package:submissions_site/api_repository.dart';
import 'package:submissions_site/screens/submissions/submissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

typedef BlocProviderSubmissionsBloc = BlocProvider<SubmissionsBloc>;

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  group('SubmissionsRoute', () {
    final ApiRepository repository = MockApiRepository();

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SubmissionsRoute(repository: repository),
        ),
      ));
      await tester.pumpAndSettle();
    }

    group('renders', () {
      testWidgets('SubmissionsView', (tester) async {
        await pumpApp(tester);
        expect(find.byType(SubmissionsView), findsOneWidget);
      });
    });

    testWidgets('fetches submissions list on initialization', (tester) async {
      await pumpApp(tester);
      verify(() => repository.fetchSubmissions()).called(1);
    });
  });
}
