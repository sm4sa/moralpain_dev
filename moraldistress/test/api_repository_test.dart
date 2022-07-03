import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      Future<Survey> placeholderSurvey() async {
        return Survey();
      }

      Future<Response<Survey>> placeholderResponse() async {
        return Response<Survey>(
          data: await placeholderSurvey(),
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
          equals(await placeholderSurvey()),
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

      test('logs error when submitSurvey fails', () {});
    });
  });
}
