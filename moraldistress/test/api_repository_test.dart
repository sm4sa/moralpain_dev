import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moraldistress/api_repository.dart';
import 'package:moralpainapi/moralpainapi.dart';

class MockMoralpainapi extends Mock implements Moralpainapi {}

class MockUserApi extends Mock implements UserApi {}

class MockLogger extends Mock implements Logger {}

extension AddApi on ApiRepository {
  void setApi(Moralpainapi mapi) {
    this.mapi = mapi;
  }

  void setLogger(Logger log) {
    this.log = log;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('ApiRepository', () {
    late ApiRepository apiRepository;
    late Moralpainapi mapi;
    late UserApi uapi;
    late Logger log;

    setUp(() {
      apiRepository = ApiRepository();
      mapi = MockMoralpainapi();
      uapi = MockUserApi();
      log = MockLogger();

      apiRepository.setApi(mapi);
      apiRepository.setLogger(log);
      when(() => mapi.getUserApi()).thenReturn(uapi);
    });

    group('fetchSurvey', () {
      Survey placeholderSurvey() {
        return Survey();
      }

      Future<Response<Survey>> placeholderResponse() async {
        return Response<Survey>(
          data: placeholderSurvey(),
          requestOptions: RequestOptions(path: ''),
        );
      }

      test('calls getSurvey', () async {
        try {
          await apiRepository.fetchSurvey();
        } catch (_) {}
        verify(() => uapi.getSurvey()).called(1);
      });

      test('logs error and calls fetchSurveyAt when getSurvey fails', () async {
        when(() => uapi.getSurvey()).thenThrow(Exception('oops'));
        Survey survey = await apiRepository.fetchSurvey();
        verify(() => log.warning(any(), any())).called(1);
        expect(survey, equals(await apiRepository.fetchSurveyAt('')));
      });

      test('returns correct Survey on success', () async {
        when(() => uapi.getSurvey()).thenAnswer((_) => placeholderResponse());
        expect(
          await apiRepository.fetchSurvey(),
          equals(placeholderSurvey()),
        );
      });
    });

    group('fetchSurveyAt', () {
      // TODO: Find survey path that works as a parameter
      // Currently having issues with rootBundle.loadString(),
      // as it always givens an "Unable to load asset" error no matter what

      test(
        'logs error and returns empty Survey if survey path is invalid',
        () async {
          Survey survey = await apiRepository.fetchSurveyAt('');
          verify(() => log.shout(any(), any())).called(1);
          expect(survey, equals(Survey()));
        },
      );
    });

    group('submitSurvey', () {
      Submission placeholderSubmission = Submission();

      test('calls submitSurvey in the API', () async {
        try {
          await apiRepository.submitSurvey(placeholderSubmission);
        } catch (_) {}
        verify(() => uapi.submitSurvey(
              submission: placeholderSubmission,
            )).called(1);
      });

      test('logs error and returns false when submitSurvey fails', () async {
        when(
          () => uapi.submitSurvey(submission: any(named: 'submission')),
        ).thenThrow(Exception('oops'));
        bool success = await apiRepository.submitSurvey(placeholderSubmission);
        verify(() => log.shout(any(), any())).called(1);
        expect(success, isFalse);
      });

      test(
        'returns false '
        'when response from submitSurvey has success code other than 200',
        () async {
          when(
            () => uapi.submitSurvey(submission: any(named: 'submission')),
          ).thenAnswer((_) => Future.value(
                Response<String>(
                  requestOptions: RequestOptions(path: ''),
                  statusCode: 404,
                ),
              ));
          bool success =
              await apiRepository.submitSurvey(placeholderSubmission);
          expect(success, isFalse);
        },
      );

      test(
        'returns true when response from submitSurvey has success code 200',
        () async {
          when(
            () => uapi.submitSurvey(submission: any(named: 'submission')),
          ).thenAnswer((_) => Future.value(
                Response<String>(
                  requestOptions: RequestOptions(path: ''),
                  statusCode: 200,
                ),
              ));
          bool success =
              await apiRepository.submitSurvey(placeholderSubmission);
          expect(success, isTrue);
        },
      );
    });

    group('fetchResiliencyResources', () {
      ResiliencyResources placeholderResources() {
        return ResiliencyResources();
      }

      Future<Response<ResiliencyResources>> placeholderResponse() async {
        return Response<ResiliencyResources>(
          data: placeholderResources(),
          requestOptions: RequestOptions(path: ''),
        );
      }

      test('calls getResiliencyResources', () async {
        try {
          await apiRepository.fetchResiliencyResources();
        } catch (_) {}
        verify(() => uapi.getResiliencyResources()).called(1);
      });

      test(
        'logs error and returns empty ResiliencyResources'
        'when getResiliencyResources fails',
        () async {
          when(() => uapi.getResiliencyResources())
              .thenThrow(Exception('oops'));
          ResiliencyResources resources =
              await apiRepository.fetchResiliencyResources();
          verify(() => log.warning(any(), any())).called(1);
          expect(resources, equals(ResiliencyResources()));
        },
      );

      test('returns correct ResiliencyResources on success', () async {
        when(() => uapi.getResiliencyResources())
            .thenAnswer((_) => placeholderResponse());
        ResiliencyResources resources =
            await apiRepository.fetchResiliencyResources();
        expect(resources, equals(placeholderResources()));
      });
    });

    group('submitVisitedResources', () {
      VisitedResiliencyResources placeholderResources =
          VisitedResiliencyResources();

      test('calls submitVisitedResiliencyResources', () async {
        try {
          await apiRepository.submitVisitedResources(placeholderResources);
        } catch (_) {}
        verify(() => uapi.submitVisitedResiliencyResources(
              visitedResiliencyResources: placeholderResources,
            )).called(1);
      });

      test(
        'logs error and returns false '
        'when submitVisitedResiliencyResources fails',
        () async {
          when(
            () => uapi.submitVisitedResiliencyResources(
              visitedResiliencyResources:
                  any(named: 'visitedResiliencyResources'),
            ),
          ).thenThrow(Exception('oops'));
          bool success = await apiRepository.submitVisitedResources(
            placeholderResources,
          );
          verify(() => log.warning(any(), any())).called(1);
          expect(success, isFalse);
        },
      );

      test(
        'returns false when response from submitVisitedResiliencyResources '
        'has status code other than 200',
        () async {
          when(
            () => uapi.submitVisitedResiliencyResources(
              visitedResiliencyResources:
                  any(named: 'visitedResiliencyResources'),
            ),
          ).thenAnswer((_) => Future.value(
                Response<String>(
                  requestOptions: RequestOptions(path: ''),
                  statusCode: 404,
                ),
              ));
          expect(
            await apiRepository.submitVisitedResources(placeholderResources),
            isFalse,
          );
        },
      );

      test(
        'returns true when response from submitVisitedResiliencyResources '
        'has status code 200',
        () async {
          when(
            () => uapi.submitVisitedResiliencyResources(
              visitedResiliencyResources:
                  any(named: 'visitedResiliencyResources'),
            ),
          ).thenAnswer((_) => Future.value(
                Response<String>(
                  requestOptions: RequestOptions(path: ''),
                  statusCode: 200,
                ),
              ));
          expect(
            await apiRepository.submitVisitedResources(placeholderResources),
            isTrue,
          );
        },
      );
    });
  });
}
