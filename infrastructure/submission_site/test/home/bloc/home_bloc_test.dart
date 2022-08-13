import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/api_repository.dart';
import 'package:submission_site/home/home.dart';

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LoginBloc', () {
    late ApiRepository repository;
    const String defaultId = 'f2f2011c-8d25-4784-9dfc-e99ae4b75797';
    const int defaultScore = 4;
    const int defaultTimestamp = 1647907200;
    const List<String> defaultSelections = ['001_01', '002_01', '004_01'];
    late Submission defaultSubmission;
    late Survey defaultSurvey;

    setUp(() async {
      repository = MockApiRepository();

      final SubmissionBuilder submissionBuilder = SubmissionBuilder();
      submissionBuilder.id = defaultId;
      submissionBuilder.score = defaultScore;
      submissionBuilder.timestamp = defaultTimestamp;
      submissionBuilder.selections = ListBuilder<String>(defaultSelections);
      defaultSubmission = submissionBuilder.build();

      final json = await rootBundle.loadString('assets/local_survey.json');
      defaultSurvey = standardSerializers.fromJson(Survey.serializer, json)!;
    });

    HomeBloc buildBloc() {
      return HomeBloc(repository: repository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test(
        'has correct initial state',
        () => expect(buildBloc().state, equals(const HomeState())),
      );
    });

    group('TimestampChanged', () {
      blocTest<HomeBloc, HomeState>(
        'emits state with updated timestamp',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeTimestampChanged(defaultTimestamp)),
        expect: () => [
          const HomeState(timestamp: defaultTimestamp),
        ],
      );
    });

    group('ScoreChanged', () {
      blocTest<HomeBloc, HomeState>(
        'emits state with updated score',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeScoreChanged(defaultScore)),
        expect: () => [
          const HomeState(score: defaultScore),
        ],
      );
    });

    group('SelectionsChanged', () {
      blocTest<HomeBloc, HomeState>(
        'emits state with updated selections',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSelectionsChanged(defaultSelections)),
        expect: () => [
          const HomeState(selections: defaultSelections),
        ],
      );
    });

    group('SubmissionRequested', () {
      blocTest<HomeBloc, HomeState>(
        'calls fetchSubmission()',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubmissionRequested(defaultId)),
        verify: (_) {
          verify(() => repository.fetchSubmission(defaultId)).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [SubmissionStatus.loading, SubmissionStatus.success] '
        'and then adds HomeSurveyRequested '
        'when fetchSubmission() is succesful',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubmissionRequested(defaultId)),
        setUp: () {
          when(() => repository.fetchSubmission(any())).thenAnswer(
            (_) => Future.value(defaultSubmission),
          );
          when(() => repository.fetchSurvey()).thenAnswer(
            (_) => Future.value(defaultSurvey),
          );
        },
        expect: () => [
          const HomeState(submissionStatus: SubmissionStatus.loading),
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
          ),
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            surveyStatus: SurveyStatus.loading,
          ),
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          )
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits [SubmissionStatus.loading, SubmissionStatus.failure '
        'when fetchSubmissions() fails',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubmissionRequested(defaultId)),
        setUp: () {
          when(() => repository.fetchSubmission(any())).thenThrow(Exception());
        },
        expect: () => [
          const HomeState(submissionStatus: SubmissionStatus.loading),
          const HomeState(submissionStatus: SubmissionStatus.failure),
        ],
      );
    });

    group('SurveyRequested', () {
      blocTest<HomeBloc, HomeState>(
        'calls fetchSurvey()',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSurveyRequested()),
        verify: (_) {
          verify(() => repository.fetchSurvey()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [SurveyStatus.loading, SurveyStatus.success] '
        'when fetchSurvey() is successful',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSurveyRequested()),
        setUp: () {
          when(() => repository.fetchSurvey()).thenThrow(Exception());
        },
        expect: () => [
          const HomeState(surveyStatus: SurveyStatus.loading),
          const HomeState(surveyStatus: SurveyStatus.failure)
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits [SurveyStatus.loading, SurveyStatus.failure] '
        'when fetchSurvey() is successful',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSurveyRequested()),
        setUp: () {
          when(() => repository.fetchSurvey()).thenAnswer(
            (_) => Future.value(defaultSurvey),
          );
        },
        expect: () => [
          const HomeState(surveyStatus: SurveyStatus.loading),
          HomeState(
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          )
        ],
      );
    });

    group('ChangesReverted', () {
      const int newTimestamp = 1659312000;
      const int newScore = 2;
      const List<String> newSelections = ['001_01', '002_01'];

      blocTest<HomeBloc, HomeState>(
        'emits state with reverted timestamp, score, and selections',
        build: buildBloc,
        setUp: () {
          when(() => repository.fetchSubmission(defaultId)).thenAnswer(
            (_) => Future.value(defaultSubmission),
          );
          when(() => repository.fetchSurvey()).thenAnswer(
            (_) => Future.value(defaultSurvey),
          );
        },
        act: (bloc) async {
          // Load default values
          bloc.add(const HomeSubmissionRequested(defaultId));

          // Change to new values
          await Future.delayed(const Duration(milliseconds: 1000));
          bloc.add(const HomeTimestampChanged(newTimestamp));
          bloc.add(const HomeScoreChanged(newScore));
          bloc.add(const HomeSelectionsChanged(newSelections));

          // Revert changes
          bloc.add(const HomeChangesReverted());
        },
        expect: () => [
          // Expect submission + default values to be loaded
          const HomeState(submissionStatus: SubmissionStatus.loading),
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
          ),
          // Expect survey to be loaded
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            surveyStatus: SurveyStatus.loading,
          ),
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          // Expect default values to be replaced with new values
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: newScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: newScore,
            selections: newSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          // Expect timestamp, score, and selections to be reverted
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
        ],
      );
    });

    group('ChangesSubmitted', () {
      const int newTimestamp = 1659312000;
      const int newScore = 2;
      const List<String> newSelections = ['001_01', '002_01'];
      late Submission newSubmission;

      setUpAll(() {
        registerFallbackValue(Submission());
      });

      setUp(() {
        final builder = SubmissionBuilder();
        builder.id = defaultId;
        builder.timestamp = newTimestamp;
        builder.score = newScore;
        builder.selections = ListBuilder(newSelections);
        newSubmission = builder.build();

        when(() => repository.fetchSubmission(any())).thenAnswer(
          (_) => Future.value(defaultSubmission),
        );
        when(() => repository.fetchSurvey()).thenAnswer(
          (_) => Future.value(defaultSurvey),
        );
        when(() => repository.submitSubmission(any())).thenAnswer(
          (_) => Future.value(true),
        );
      });

      blocTest<HomeBloc, HomeState>(
        'calls submitSubmission()',
        build: buildBloc,
        act: (bloc) async {
          // Load default values
          bloc.add(const HomeSubmissionRequested(defaultId));

          // Change to new values
          await Future.delayed(const Duration(milliseconds: 1000));
          bloc.add(const HomeTimestampChanged(newTimestamp));
          bloc.add(const HomeScoreChanged(newScore));
          bloc.add(const HomeSelectionsChanged(newSelections));

          // Revert changes
          bloc.add(const HomeChangesSubmitted());
        },
        verify: (_) {
          verify(() => repository.submitSubmission(newSubmission)).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits state with SubmitStatus.success and updated submission '
        'if submitSubmission() succeeds',
        build: buildBloc,
        act: (bloc) async {
          // Load default values
          bloc.add(const HomeSubmissionRequested(defaultId));

          // Change to new values
          await Future.delayed(const Duration(milliseconds: 1000));
          bloc.add(const HomeTimestampChanged(newTimestamp));
          bloc.add(const HomeScoreChanged(newScore));
          bloc.add(const HomeSelectionsChanged(newSelections));

          // Submit changes
          bloc.add(const HomeChangesSubmitted());
        },
        expect: () => [
          // Expect submission + default values to be loaded
          const HomeState(submissionStatus: SubmissionStatus.loading),
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
          ),
          // Expect survey to be loaded
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            surveyStatus: SurveyStatus.loading,
          ),
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          // Expect default values to be replaced with new values
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: newScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: newScore,
            selections: newSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          // Expect submission to be updated
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: newScore,
            selections: newSelections,
            submission: newSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
            submitStatus: SubmitStatus.success,
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits state with SubmitStatus.failure if submitSubmission() fails',
        build: buildBloc,
        setUp: () {
          when(() => repository.submitSubmission(any())).thenAnswer(
            (_) => Future.value(false),
          );
        },
        act: (bloc) async {
          // Load default values
          bloc.add(const HomeSubmissionRequested(defaultId));

          // Change to new values
          await Future.delayed(const Duration(milliseconds: 1000));
          bloc.add(const HomeTimestampChanged(newTimestamp));
          bloc.add(const HomeScoreChanged(newScore));
          bloc.add(const HomeSelectionsChanged(newSelections));

          // Submit changes
          bloc.add(const HomeChangesSubmitted());
        },
        expect: () => [
          // Expect submission + default values to be loaded
          const HomeState(submissionStatus: SubmissionStatus.loading),
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
          ),
          // Expect survey to be loaded
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            surveyStatus: SurveyStatus.loading,
          ),
          HomeState(
            id: defaultId,
            timestamp: defaultTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          // Expect default values to be replaced with new values
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: defaultScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: newScore,
            selections: defaultSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: newScore,
            selections: newSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
          ),
          // Expect SubmitStatus.failure
          HomeState(
            id: defaultId,
            timestamp: newTimestamp,
            score: newScore,
            selections: newSelections,
            submission: defaultSubmission,
            submissionStatus: SubmissionStatus.success,
            survey: defaultSurvey,
            surveyStatus: SurveyStatus.success,
            submitStatus: SubmitStatus.failure,
          ),
        ],
      );
    });
  });
}
