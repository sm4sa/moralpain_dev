import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/home/home.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  group('FieldList', () {
    late HomeState mockState;
    late HomeBloc mockBloc;

    setUp(() {
      // Build mock submission
      final SubmissionBuilder submissionBuilder = SubmissionBuilder();
      submissionBuilder.id = 'f2f2011c-8d25-4784-9dfc-e99ae4b75797';
      submissionBuilder.timestamp = 1647907200;
      submissionBuilder.score = 4;
      submissionBuilder.selections = ListBuilder(
        ['001_01', '001_02', '001_03'],
      );
      final Submission mockSubmission = submissionBuilder.build();

      // Build mock survey
      final List<SurveyOption> surveyOptions = [];
      for (int i = 1; i <= 3; i++) {
        final SurveyOptionBuilder optionBuilder = SurveyOptionBuilder();
        optionBuilder.id = '0$i';
        optionBuilder.description = 'Contributing factor $i';
        surveyOptions.add(optionBuilder.build());
      }

      final SurveySectionBuilder sectionBuilder = SurveySectionBuilder();
      sectionBuilder.sectionId = '001';
      sectionBuilder.title = 'Section title';
      sectionBuilder.subtitle = 'Section subtitle';
      sectionBuilder.options = ListBuilder(surveyOptions);
      final SurveySection surveySection = sectionBuilder.build();

      final SurveyBuilder surveyBuilder = SurveyBuilder();
      surveyBuilder.version = '1.0.0';
      surveyBuilder.sections = ListBuilder([surveySection]);
      final Survey mockSurvey = surveyBuilder.build();

      // Create mock state
      mockState = HomeState(
        id: mockSubmission.id,
        score: mockSubmission.score,
        timestamp: mockSubmission.timestamp,
        selections: mockSubmission.selections!.asList(),
        submission: mockSubmission,
        submissionStatus: SubmissionStatus.success,
        survey: mockSurvey,
        surveyStatus: SurveyStatus.success,
      );

      // Create and set up mock bloc
      mockBloc = MockHomeBloc();
      when(() => mockBloc.state).thenReturn(mockState);
      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(mockState));
      when(() => mockBloc.close()).thenAnswer((_) => Future.value());
    });

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider<HomeBloc>.value(
            value: mockBloc,
            child: FieldList(),
          ),
        ),
      ));
    }

    testWidgets(
      'renders three FieldDisplay widgets, each with correct text',
      (tester) async {
        await pumpApp(tester);
        expect(find.byType(FieldDisplay), findsNWidgets(3));
        expect(
          find.text(
            'Time submitted: '
            '${FieldList.displayTimestamp(mockState.timestamp!)}',
          ),
          findsOneWidget,
        );
        expect(
            find.text('Score: ${mockState.score} out of 10'), findsOneWidget);
        expect(
          find.text(
            'Contributing factors: '
            '${FieldList.displaySelections(
              mockState.selections!,
              mockState.survey!,
            )}',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets('FieldDisplays have correct keys', (tester) async {
      await pumpApp(tester);
      expect(
        find.byKey(const Key('fieldList_timestampEdit_fieldDisplay')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('fieldList_scoreEdit_fieldDisplay')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('fieldList_contributingFactorsEdit_fieldDisplay')),
        findsOneWidget,
      );
    });

    testWidgets('IconButtons have correct keys', (tester) async {
      await pumpApp(tester);
      expect(
        find.byKey(const Key('fieldDisplay_timestampEdit_iconButton')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('fieldDisplay_scoreEdit_iconButton')),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const Key('fieldDisplay_contributingFactorsEdit_iconButton'),
        ),
        findsOneWidget,
      );
    });
  });
}
