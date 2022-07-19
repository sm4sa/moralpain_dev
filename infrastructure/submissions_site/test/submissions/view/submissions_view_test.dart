import 'dart:io';

import 'package:submissions_site/api_repository.dart';
import 'package:submissions_site/filter_submissions/filter_submissions.dart';
import 'package:submissions_site/submissions/submissions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moralpainapi/moralpainapi.dart';

void main() {
  group('SubmissionsView', () {
    final String errorMsg = 'Error fetching submissions';

    late ApiRepository repository;
    late SubmissionsBloc bloc;

    setUp(() {
      repository = ApiRepository();
      bloc = SubmissionsBloc(repository: repository);
    });

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RepositoryProvider.value(
            value: repository,
            child: BlocProvider(
              create: (_) => bloc,
              child: SubmissionsView(),
            ),
          ),
        ),
      ));
    }

    group('renders', () {
      testWidgets('FilterSubmissionsView', (tester) async {
        await pumpApp(tester);
        expect(find.byType(FilterSubmissionsView), findsOneWidget);
      });

      testWidgets('submissionsFromState()', (tester) async {
        await pumpApp(tester);
        // There should always be a Center widget, no matter what.
        expect(find.byType(Center), findsOneWidget);

        /* 
        There should be exactly one of the following:
          * a CircularProgressIndicator (if status is SubmissionsInitial or 
              SubmissionsLoading)
          * a Scrollbar (if status is SubmissionsLoaded)
          * a Text (if status is SubmissionsLoadFailure)
        */
        Finder findProgressIndicators = find.descendant(
          of: find.byType(Center),
          matching: find.byType(CircularProgressIndicator),
        );
        Finder findScrollbars = find.descendant(
          of: find.byType(Center),
          matching: find.byType(Scrollbar),
        );
        Finder findTexts = find.descendant(
          of: find.byType(Center),
          matching: find.byType(Text),
        );

        int numProgressIndicators = findProgressIndicators.evaluate().length;
        int numScrollbars = findScrollbars.evaluate().length;
        int numTexts = findTexts.evaluate().length;

        bool isInitialOrLoading =
            numProgressIndicators == 1 && numScrollbars == 0 && numTexts == 0;
        bool isLoaded = numProgressIndicators == 0 && numScrollbars == 1;
        bool isLoadFailure =
            numProgressIndicators == 0 && numScrollbars == 0 && numTexts == 1;

        expect(isInitialOrLoading || isLoaded || isLoadFailure, isTrue);
      });
    });

    group('submissionsFromState', () {
      Future<void> pumpApp(WidgetTester tester, SubmissionsState state) async {
        await tester.pumpWidget(MaterialApp(
          home: Column(
            children: [SubmissionsView.submissionsFromState(state)],
          ),
        ));
      }

      testWidgets(
        'renders CircularProgressIndicator when status is SubmissionsInitial',
        (tester) async {
          await pumpApp(tester, SubmissionsInitial());
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        'renders CircularProgressIndicator when status is SubmissionsLoading',
        (tester) async {
          await pumpApp(tester, SubmissionsLoading());
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        'renders list of submissions when status is SubmissionsLoaded',
        (tester) async {
          SubmissionsLoaded state = SubmissionsLoaded(Submissions());
          await pumpApp(tester, state);
          Widget message = SubmissionsView.messageFromSubmissions(
            state.submissions,
          );

          // Verify that the message is either a Text or a CupertinoScrollbar
          expect(
            message.runtimeType == Text ||
                message.runtimeType == CupertinoScrollbar,
            isTrue,
          );

          /*
          If the message is a Text, verify that there exists a Text 
          with matching data
          */
          if (message.runtimeType == Text) {
            String? data = (message as Text).data;
            expect(data, isNotNull);
            expect(find.text(data!), findsOneWidget);
          } else if (message.runtimeType == CupertinoScrollbar) {
            expect(find.byType(CupertinoScrollbar), findsOneWidget);
          }
        },
      );

      testWidgets('renders error message when status is SubmissionsLoadFailed',
          (tester) async {
        await pumpApp(tester, SubmissionsLoadFailed());
        expect(find.text(errorMsg), findsOneWidget);
      });
    });

    group('messageFromSubmissions', () {
      test('returns correct Text if list of submissions is null', () {
        Submissions submissions = Submissions();
        expect(submissions.list, isNull);

        Widget message = SubmissionsView.messageFromSubmissions(submissions);
        expect(message.runtimeType, equals(Text));
        expect((message as Text).data, equals('No list of submissions.'));
      });

      test('returns correct Text if list of submissions is empty', () {
        String json = '{"list": []}';
        Submissions? submissions = standardSerializers.fromJson(
          Submissions.serializer,
          json,
        );
        expect(submissions, isNotNull);
        expect(submissions!.list, isNotNull);
        expect(submissions.list!.length, equals(0));

        Widget message = SubmissionsView.messageFromSubmissions(submissions);
        expect(message.runtimeType, equals(Text));
        expect((message as Text).data, equals('List of submissions is empty.'));
      });

      testWidgets(
        'returns ListView with all submissions '
        'if list of Submissions is not empty',
        (tester) async {
          // Generate Submissions object and verify that it is correct
          File file = File(
            '/workspaces/moralpain_dev/infrastructure/submissions_site/test/screens/submissions/view/submissions_example.json',
          );
          String json = file.readAsStringSync();
          Submissions? submissions = standardSerializers.fromJson(
            Submissions.serializer,
            json,
          );
          expect(submissions, isNotNull);
          expect(submissions!.list, isNotNull);
          expect(submissions.list!.length, equals(2));

          // Render message
          await tester.pumpWidget(MaterialApp(
            home: Scaffold(
              body: SubmissionsView.messageFromSubmissions(submissions),
            ),
          ));

          // Verify that the message is a scrollbar
          expect(find.byType(Scrollbar), findsOneWidget);

          // Verify that the scrollbar contains a ListView
          expect(find.byType(ListView), findsOneWidget);

          // Verify that the ListView contains exactly 2 SubmissionListTiles
          expect(find.byType(SubmissionListTile), findsNWidgets(2));
        },
      );
    });
  });
}
