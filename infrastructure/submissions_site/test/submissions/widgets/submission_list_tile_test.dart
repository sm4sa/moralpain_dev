import 'package:built_collection/built_collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submissions_site/submissions/widgets/widgets.dart';

void main() {
  group('SubmissionListTile', () {
    Submission buildSubmission() {
      final builder = SubmissionBuilder();
      builder.timestamp = 1658160000;
      builder.id = '86bc6fe40d564540bb1a50e59550e3e0';
      builder.score = 4;
      builder.selections = ListBuilder<String>(['001_01', '002_02', '003_03']);
      return builder.build();
    }

    Future<void> pumpApp(WidgetTester tester, Submission submission) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SubmissionListTile(submission),
        ),
      ));
    }

    testWidgets('is an ExpandablePanel', (tester) async {
      await pumpApp(tester, Submission());
      expect(find.byType(ExpandablePanel), findsOneWidget);
    });

    testWidgets('has time of submission as title', (tester) async {
      await pumpApp(tester, buildSubmission());
      expect(find.text('2022-07-18 16:00:00.000'), findsOneWidget);
    });

    testWidgets(
      'says in title that there is no submission time '
      'if there is no submission time',
      (tester) async {
        await pumpApp(tester, Submission());
        expect(find.text('No date for this submission'), findsOneWidget);
      },
    );

    testWidgets(
      'has correct field values in body if all fields are non-null',
      (tester) async {
        await pumpApp(tester, buildSubmission());
        expect(
          find.text(
            'Submission time: 2022-07-18 16:00:00.000 (GMT)\n'
            'Score: 4 out of 10\n'
            'User ID: 86bc6fe40d564540bb1a50e59550e3e0\n'
            'Items selected: 001_01, 002_02, 003_03',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'displays in body that no field values are available '
      'if all fields are null',
      (tester) async {
        await pumpApp(tester, Submission());
        expect(
          find.text(
            'Submission time: not available\n'
            'Score: not available\n'
            'User ID: not available\n'
            'Items selected: not available',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'displays in body that no choices were selected '
      'if list of items selected is empty',
      (tester) async {
        final builder = SubmissionBuilder();
        builder.selections = ListBuilder([]);
        await pumpApp(tester, builder.build());
        expect(
          find.text(
            'Submission time: not available\n'
            'Score: not available\n'
            'User ID: not available\n'
            'Items selected: none selected',
          ),
          findsOneWidget,
        );
      },
    );
  });
}
