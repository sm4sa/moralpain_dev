import 'package:analytics_site/api_repository.dart';
import 'package:analytics_site/analytics0/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moralpainapi/moralpainapi.dart';

typedef BlocProviderAnalyticsBloc = BlocProvider<AnalyticsBloc>;

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  late ApiRepository repository;

  setUp(() {
    repository = MockApiRepository();
    when(() => repository.fetchAnalytics(
          operation: any(named: 'operation'),
          starttime: any(named: 'starttime'),
          endtime: any(named: 'endtime'),
        )).thenAnswer((_) => Future.value(AnalyticsResult()));
  });

  group('AnalyticsRoute', () {
    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: AnalyticsRoute(repository: repository),
      ));
    }

    group('renders', () {
      testWidgets('BlocProvider', (tester) async {
        await pumpApp(tester);
        expect(find.byType(BlocProviderAnalyticsBloc), findsOneWidget);
      });

      testWidgets('AnalyticsView', (tester) async {
        await pumpApp(tester);
        expect(find.byType(AnalyticsView), findsOneWidget);
      });
    });

    testWidgets('fetches analytics on initialization', (tester) async {
      await pumpApp(tester);
      verify(() => repository.fetchAnalytics(
            operation: any(named: 'operation'),
            starttime: any(named: 'starttime'),
            endtime: any(named: 'endtime'),
          )).called(1);
    });
  });

  group('AnalyticsView', () {
    late AnalyticsBloc bloc;

    setUp(() {
      bloc = AnalyticsBloc(repository: repository);
    });

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: RepositoryProvider.value(
          value: repository,
          child: BlocProvider(
            create: (_) => bloc,
            child: AnalyticsView(),
          ),
        ),
      ));
    }

    group('renders', () {
      testWidgets('analyticsFromState', (tester) async {
        await pumpApp(tester);
        /*
        analyticsFromState() returns either one Text or one 
        CircularProgressIndicator. There should be exactly one object of either 
        of those types.
        */
        int numTextWidgets = find.byType(Text).evaluate().length;
        int numCPIWidgets =
            find.byType(CircularProgressIndicator).evaluate().length;
        expect(
            (numTextWidgets == 1 && numCPIWidgets == 0) ||
                (numTextWidgets == 0 || numCPIWidgets == 1),
            isTrue);
      });
    });

    group('analyticsFromState', () {
      Future<void> pumpApp(WidgetTester tester, AnalyticsState state) async {
        await tester.pumpWidget(MaterialApp(
          home: Column(
            children: [AnalyticsView.analyticsFromState(state)],
          ),
        ));
      }

      testWidgets(
        'returns status message when state is AnalyticsInitial',
        (tester) async {
          await pumpApp(tester, const AnalyticsInitial());
          expect(find.text('No analytics yet.'), findsOneWidget);
        },
      );

      testWidgets(
        'returns progress indicator when state is AnalyticsInProgress',
        (tester) async {
          await pumpApp(tester, const AnalyticsInProgress());
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        'returns analytics message when state is AnalyticsSuccess '
        'and error is false',
        (tester) async {
          AnalyticsResultBuilder builder = AnalyticsResultBuilder();
          builder.operation = AnalyticsResultOperationEnum.count;
          builder.result = 1337;
          builder.error = false;
          builder.errormsg = null;
          AnalyticsResult analyticsResult = builder.build();

          AnalyticsSuccess state = AnalyticsSuccess(analyticsResult);
          await pumpApp(tester, state);
          expect(
            find.text(AnalyticsView.messageFromResult(
              operation: state.result.operation!,
              result: state.result.result!,
            )),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'returns error message when state is AnalyticsSuccess '
        'and error is true',
        (tester) async {
          AnalyticsResultBuilder builder = AnalyticsResultBuilder();
          builder.operation = AnalyticsResultOperationEnum.count;
          builder.result = null;
          builder.error = true;
          builder.errormsg = 'Looks like you done screwed the pooch.';
          AnalyticsResult analyticsResult = builder.build();

          AnalyticsSuccess state = AnalyticsSuccess(analyticsResult);
          await pumpApp(tester, state);
          expect(
            find.text('Error fetching analytics: ${state.result.errormsg}'),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'returns error message when state is AnalyticsSuccess '
        'and error is null',
        (tester) async {
          AnalyticsResult analyticsResult = AnalyticsResult();

          AnalyticsSuccess state = AnalyticsSuccess(analyticsResult);
          await pumpApp(tester, state);
          expect(
            find.text('Error fetching analytics: ${state.result.errormsg}'),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'returns error message when state is AnalyticsFailure',
        (tester) async {
          await pumpApp(tester, const AnalyticsFailure());
          expect(
            find.text('Error fetching analytics.'),
            findsOneWidget,
          );
        },
      );
    });

    group('messageFromResult', () {
      const num result = 3;

      test('returns correct message for average operation', () {
        expect(
          AnalyticsView.messageFromResult(
              operation: AnalyticsResultOperationEnum.average, result: result),
          equals('The average score is $result.'),
        );
      });

      test('returns correct message for count operation', () {
        expect(
          AnalyticsView.messageFromResult(
              operation: AnalyticsResultOperationEnum.count, result: result),
          equals('The number of submissions is $result.'),
        );
      });

      test('returns correct message for maximum operation', () {
        expect(
          AnalyticsView.messageFromResult(
              operation: AnalyticsResultOperationEnum.maximum, result: result),
          equals('The maximum score is $result.'),
        );
      });

      test('returns correct message for minimum operation', () {
        expect(
          AnalyticsView.messageFromResult(
              operation: AnalyticsResultOperationEnum.minimum, result: result),
          equals('The minimum score is $result.'),
        );
      });
    });
  });
}
