import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/home/home.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomeView', () {
    late HomeBloc mockBloc;

    setUp(() {
      mockBloc = MockHomeBloc();
      when(() => mockBloc.close()).thenAnswer((_) async {});
    });

    void setMockBlockState(HomeState state) {
      when(() => mockBloc.state).thenReturn(state);
      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(state));
    }

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: mockBloc,
            child: const HomeView(),
          ),
        ),
      ));
    }

    group('when SubmissionStatus is initial', () {
      setUp(() {
        setMockBlockState(const HomeState());
      });

      testWidgets('renders progress indicator', (tester) async {
        await pumpApp(tester);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('when SubmissionStatus is loading', () {
      setUp(() {
        setMockBlockState(const HomeState(
          submissionStatus: SubmissionStatus.loading,
        ));
      });

      testWidgets('renders progress indicator', (tester) async {
        await pumpApp(tester);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('when SubmissionStatus is success', () {
      const String id = '119ada26-a0ba-4991-82f4-d6aa7c73c503';
      const int timestamp = 1658944322;
      const int score = 4;
      const List<String> selections = ['001_02', '001_03', '002_02', '004_06'];
      late Submission submission;
      late HomeState submissionSuccessState;

      setUp(() {
        final builder = SubmissionBuilder();
        builder.id = id;
        builder.timestamp = timestamp;
        builder.score = score;
        builder.selections = ListBuilder(selections);
        submission = builder.build();

        submissionSuccessState = HomeState(
          id: id,
          timestamp: timestamp,
          score: score,
          selections: selections,
          submission: submission,
          submissionStatus: SubmissionStatus.success,
        );
      });

      group('and SurveyStatus is initial', () {
        setUp(() {
          setMockBlockState(submissionSuccessState);
        });

        testWidgets('renders progress indicator', (tester) async {
          await pumpApp(tester);
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        });
      });

      group('and SurveyStatus is loading', () {
        setUp(() {
          setMockBlockState(submissionSuccessState.copyWith(
            surveyStatus: SurveyStatus.loading,
          ));
        });

        testWidgets('renders progress indicator', (tester) async {
          await pumpApp(tester);
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        });
      });

      group('and SurveyStatus is success', () {
        late Survey survey;

        setUp(() async {
          final json = await rootBundle.loadString('assets/local_survey.json');
          survey = standardSerializers.fromJson(Survey.serializer, json)!;

          setMockBlockState(submissionSuccessState.copyWith(
            survey: survey,
            surveyStatus: SurveyStatus.success,
          ));
        });

        group('renders', () {
          testWidgets('AppBar with correct title text', (tester) async {
            await pumpApp(tester);
            expect(find.byType(AppBar), findsOneWidget);
            final AppBar appBar = tester.widget(find.byType(AppBar));
            expect(appBar.title, isA<Text>());
            expect((appBar.title as Text).data, equals('Submission ID $id'));
          });

          testWidgets('FieldList widget', (tester) async {
            await pumpApp(tester);
            expect(find.byType(FieldList), findsOneWidget);
          });

          testWidgets('RevertSubmitChangesWidget', (tester) async {
            await pumpApp(tester);
            expect(find.byType(RevertSubmitChangesWidget), findsOneWidget);
          });

          /*testWidgets(
            'three FieldDisplay widgets, each with correct text',
            (tester) async {
              await pumpApp(tester);
              expect(find.byType(FieldDisplay), findsNWidgets(3));
              expect(
                find.text(
                  'Time submitted: ${FieldList.displayTimestamp(timestamp)}',
                ),
                findsOneWidget,
              );
              expect(find.text('Score: $score out of 10'), findsOneWidget);
              expect(
                find.text(
                  'Contributing factors: '
                  '${FieldList.displaySelections(selections, survey)}',
                ),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'two ElevatedButtons, each with correct text',
            (tester) async {
              await pumpApp(tester);
              expect(find.byType(ElevatedButton), findsNWidgets(2));
              expect(find.text('Revert Changes'), findsOneWidget);
              expect(find.text('Submit Changes'), findsOneWidget);
            },
          );*/

          // TODO: test buttons' effect on FieldDisplays
        });
      });

      group('and SurveyStatus is failure', () {
        setUp(() {
          setMockBlockState(submissionSuccessState.copyWith(
            surveyStatus: SurveyStatus.failure,
          ));
        });

        group('renders', () {
          testWidgets('AppBar with correct title text', (tester) async {
            await pumpApp(tester);
            expect(find.byType(AppBar), findsOneWidget);
            final AppBar appBar = tester.widget(find.byType(AppBar));
            expect(appBar.title, isA<Text>());
            expect((appBar.title as Text).data, equals('Submission ID $id'));
          });

          testWidgets('error message', (tester) async {
            await pumpApp(tester);
            expect(
              find.text(
                  'Error fetching information about contributing factors.'),
              findsOneWidget,
            );
          });
        });
      });
    });

    group('when SubmissionStatus is failure', () {
      setUp(() {
        setMockBlockState(const HomeState(
          submissionStatus: SubmissionStatus.failure,
        ));
      });

      testWidgets('renders error message', (tester) async {
        await pumpApp(tester);
        expect(find.text('Error fetching submission.'), findsOneWidget);
      });
    });

    group('areListsEqual', () {
      test('returns true when both lists are empty', () {
        expect(HomeView.areListsEqual([], []), isTrue);
      });

      test(
        'returns true when each list has the same elements in the same order',
        () {
          expect(
            HomeView.areListsEqual(
              ['a', 'b', 'c', 'd'],
              ['a', 'b', 'c', 'd'],
            ),
            isTrue,
          );
        },
      );

      test(
        'returns false when lists have different lengths',
        () {
          expect(
            HomeView.areListsEqual(
              ['a', 'b', 'c', 'd'],
              ['a', 'b', 'c'],
            ),
            isFalse,
          );
        },
      );

      test(
        'returns false when lists have same elements in different orders',
        () {
          expect(
            HomeView.areListsEqual(
              ['a', 'b', 'c', 'd'],
              ['a', 'b', 'd', 'c'],
            ),
            isFalse,
          );
        },
      );

      test(
        'returns false when one list is empty and the other isn\'t',
        () {
          expect(
            HomeView.areListsEqual(
              [],
              ['a', 'b', 'c', 'd'],
            ),
            isFalse,
          );
        },
      );

      test(
        'returns false when lists have completely different elements',
        () {
          expect(
            HomeView.areListsEqual(
              ['a', 'b', 'c', 'd'],
              ['e', 'f', 'g', 'h'],
            ),
            isFalse,
          );
        },
      );
    });

    group('showSubmitDialog', () {
      void setMockBlocSubmitStatus(SubmitStatus submitStatus) {
        setMockBlockState(
          HomeState(
            id: 'a',
            timestamp: 0,
            score: 0,
            selections: const [],
            submission: Submission(),
            submissionStatus: SubmissionStatus.success,
            survey: Survey(),
            surveyStatus: SurveyStatus.success,
            submitStatus: submitStatus,
          ),
        );
      }

      testWidgets('when SubmitStatus is none does nothing', (tester) async {
        setMockBlocSubmitStatus(SubmitStatus.none);
        await pumpApp(tester);
        expect(find.byType(AlertDialog), findsNothing);
      });

      group('when SubmitStatus is success', () {
        testWidgets('renders correct alert dialog', (tester) async {
          setMockBlocSubmitStatus(SubmitStatus.success);
          await pumpApp(tester);
          await tester.pumpAndSettle();
          expect(find.byType(AlertDialog), findsOneWidget);
          expect(find.text('Changes submitted!'), findsOneWidget);
          expect(find.text('OK'), findsOneWidget);
        });
      });
    });
  });
}
