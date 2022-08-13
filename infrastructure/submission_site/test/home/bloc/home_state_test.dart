import 'package:built_collection/built_collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/home/home.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomeState', () {
    const String defaultId = 'f2f2011c-8d25-4784-9dfc-e99ae4b75797';
    const int defaultScore = 4;
    const int defaultTimestamp = 1647907200;
    const List<String> defaultSelections = ['001_01', '002_01', '004_01'];
    late Submission defaultSubmission;
    const SubmissionStatus defaultSubmissionStatus = SubmissionStatus.success;
    late Survey defaultSurvey;
    const SurveyStatus defaultSurveyStatus = SurveyStatus.success;
    const SubmitStatus defaultSubmitStatus = SubmitStatus.success;

    setUp(() async {
      final SubmissionBuilder submissionBuilder = SubmissionBuilder();
      submissionBuilder.id = defaultId;
      submissionBuilder.score = defaultScore;
      submissionBuilder.timestamp = defaultTimestamp;
      submissionBuilder.selections = ListBuilder<String>(defaultSelections);
      defaultSubmission = submissionBuilder.build();

      final json = await rootBundle.loadString('assets/local_survey.json');
      defaultSurvey = standardSerializers.fromJson(Survey.serializer, json)!;
    });

    test('supports value equality', () {
      expect(const HomeState(), const HomeState());
      expect(
        HomeState(
          id: defaultId,
          score: defaultScore,
          timestamp: defaultTimestamp,
          selections: defaultSelections,
          submission: defaultSubmission,
          submissionStatus: defaultSubmissionStatus,
          survey: defaultSurvey,
          surveyStatus: defaultSurveyStatus,
          submitStatus: defaultSubmitStatus,
        ),
        equals(HomeState(
          id: defaultId,
          score: defaultScore,
          timestamp: defaultTimestamp,
          selections: defaultSelections,
          submission: defaultSubmission,
          submissionStatus: defaultSubmissionStatus,
          survey: defaultSurvey,
          surveyStatus: defaultSurveyStatus,
          submitStatus: defaultSubmitStatus,
        )),
      );
    });

    test('props are correct', () {
      expect(
        const HomeState().props,
        equals([
          null,
          null,
          null,
          null,
          null,
          SubmissionStatus.initial,
          null,
          SurveyStatus.initial,
          SubmitStatus.none,
        ]),
      );
      expect(
        HomeState(
          id: defaultId,
          score: defaultScore,
          timestamp: defaultTimestamp,
          selections: defaultSelections,
          submission: defaultSubmission,
          submissionStatus: defaultSubmissionStatus,
          survey: defaultSurvey,
          surveyStatus: defaultSurveyStatus,
          submitStatus: defaultSubmitStatus,
        ).props,
        equals([
          defaultId,
          defaultScore,
          defaultTimestamp,
          defaultSelections,
          defaultSubmission,
          defaultSubmissionStatus,
          defaultSurvey,
          defaultSurveyStatus,
          defaultSubmitStatus
        ]),
      );
    });

    group('copyWith', () {
      test(
        'returns state with same fields when no parameters are passed',
        () {
          expect(
            const HomeState().copyWith(),
            equals(const HomeState()),
          );
        },
      );

      test(
        'returns state with same fields when all parameters are null',
        () {
          expect(
            const HomeState().copyWith(
              id: null,
              score: null,
              timestamp: null,
              selections: null,
              submission: null,
              submissionStatus: null,
              survey: null,
              surveyStatus: null,
              submitStatus: null,
            ),
            equals(const HomeState()),
          );
        },
      );

      test(
        'returns state with different fields when all parameters are non-null',
        () {
          expect(
            const HomeState().copyWith(
              id: defaultId,
              score: defaultScore,
              timestamp: defaultTimestamp,
              selections: defaultSelections,
              submission: defaultSubmission,
              submissionStatus: defaultSubmissionStatus,
              survey: defaultSurvey,
              surveyStatus: defaultSurveyStatus,
              submitStatus: defaultSubmitStatus,
            ),
            equals(HomeState(
              id: defaultId,
              score: defaultScore,
              timestamp: defaultTimestamp,
              selections: defaultSelections,
              submission: defaultSubmission,
              submissionStatus: defaultSubmissionStatus,
              survey: defaultSurvey,
              surveyStatus: defaultSurveyStatus,
              submitStatus: defaultSubmitStatus,
            )),
          );
        },
      );
    });
  });
}
