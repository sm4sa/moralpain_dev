import 'package:analytics_site/api_repository.dart';
import 'package:analytics_site/screens/analytics0/bloc/analytics_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moralpainapi/moralpainapi.dart';

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  late AnalyticsResult analyticsResult;
  late ApiRepository repository;

  setUp(() {
    AnalyticsResultBuilder builder = AnalyticsResultBuilder();
    builder.operation = AnalyticsResultOperationEnum.average;
    builder.result = 5;
    builder.error = false;
    builder.errormsg = null;
    analyticsResult = builder.build();

    repository = MockApiRepository();
    when(() => repository.fetchAnalytics(
          operation: any(named: 'operation'),
          starttime: any(named: 'starttime'),
          endtime: any(named: 'endtime'),
        )).thenAnswer((_) => Future.value(analyticsResult));
  });

  group('AnalyticsBloc', () {
    AnalyticsBloc buildBloc() {
      return AnalyticsBloc(repository: repository);
    }

    group('constructor', () {
      test('completes normally', () {
        expect(buildBloc, returnsNormally);
      });

      test('has correct initial state', () {
        expect(buildBloc().state, equals(AnalyticsInitial()));
      });
    });

    group('AnalyticsStarted', () {
      const String operation = 'average';
      const int? starttime = null;
      const int? endtime = 4;

      AnalyticsEvent buildEvent() {
        return AnalyticsStarted(
          operation: operation,
          starttime: starttime,
          endtime: endtime,
        );
      }

      blocTest<AnalyticsBloc, AnalyticsState>(
        'fetched analytics from repository',
        build: buildBloc,
        act: (bloc) => bloc.add(buildEvent()),
        verify: (_) {
          verify(
            () => repository.fetchAnalytics(
              operation: operation,
              starttime: starttime,
              endtime: endtime,
            ),
          ).called(1);
        },
      );

      blocTest<AnalyticsBloc, AnalyticsState>(
        'emits success state when fetchAnalytics completes successfully',
        build: buildBloc,
        act: (bloc) => bloc.add(buildEvent()),
        expect: () => [
          AnalyticsInProgress(),
          AnalyticsSuccess(analyticsResult),
        ],
      );

      blocTest<AnalyticsBloc, AnalyticsState>(
        'emits failure state when fetchAnalytics fails',
        setUp: () {
          when(() => repository.fetchAnalytics(
                operation: any(named: 'operation'),
                starttime: any(named: 'starttime'),
                endtime: any(named: 'endtime'),
              )).thenThrow(Exception());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(buildEvent()),
        expect: () => [
          AnalyticsInProgress(),
          AnalyticsFailure(),
        ],
      );
    });
  });
}
