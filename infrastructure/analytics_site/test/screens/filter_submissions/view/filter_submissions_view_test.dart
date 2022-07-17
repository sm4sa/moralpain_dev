import 'package:analytics_site/screens/filter_submissions/filter_submissions.dart';
import 'package:analytics_site/screens/submissions/submissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFilterSubmissionsBloc extends Mock implements FilterSubmissionsBloc {}

class MockSubmissionsBloc extends Mock implements SubmissionsBloc {}

void main() {
  group('FilterSubmissionsView', () {
    late FilterSubmissionsBloc filterSubmissionsBloc;
    late SubmissionsBloc submissionsBloc;

    const starttime = 1;
    const endtime = 732468;
    const minscore = 2;
    const maxscore = 8;

    const starttime_key = Key('filterSubmissionsView_startTime_textField');
    const endtime_key = Key('filterSubmissionsView_endTime_textField');
    const minscore_key = Key('filterSubmissionsView_minScore_textField');
    const maxscore_key = Key('filterSubmissionsView_maxScore_textField');
    const button_key = Key('filterSubmissionsView_filter_elevatedButton');

    setUp(() {
      filterSubmissionsBloc = MockFilterSubmissionsBloc();
      when(() => filterSubmissionsBloc.state)
          .thenReturn(FilterSubmissionsState());
      when(() => filterSubmissionsBloc.stream).thenAnswer(
        (_) => Stream.value(FilterSubmissionsState()),
      );
      when(() => filterSubmissionsBloc.close())
          .thenAnswer((_) => Future<void>.value());

      submissionsBloc = MockSubmissionsBloc();
      when(() => submissionsBloc.state).thenReturn(SubmissionsInitial());
      when(() => submissionsBloc.stream).thenAnswer(
        (_) => Stream.value(SubmissionsInitial()),
      );
      when(() => submissionsBloc.close())
          .thenAnswer((_) => Future<void>.value());
    });

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: MultiBlocProvider(
          providers: [
            BlocProvider<FilterSubmissionsBloc>.value(
              value: filterSubmissionsBloc,
            ),
            BlocProvider<SubmissionsBloc>.value(value: submissionsBloc),
          ],
          child: FilterSubmissionsView(),
        )),
      ));
    }

    group('renders', () {
      testWidgets('all text fields', (tester) async {
        await pumpApp(tester);
        expect(find.byKey(starttime_key), findsOneWidget);
        expect(find.byKey(endtime_key), findsOneWidget);
        expect(find.byKey(minscore_key), findsOneWidget);
        expect(find.byKey(maxscore_key), findsOneWidget);
      });

      testWidgets('"Filter" button', (tester) async {
        await pumpApp(tester);
        // Button exists
        expect(find.byKey(button_key), findsOneWidget);

        // Button has text
        ElevatedButton button = tester.widget(find.byKey(button_key));
        expect(button.child, isA<Text>());

        // Button has correct text
        Text buttonText = button.child as Text;
        expect(buttonText.data, equals('Filter'));
      });
    });

    testWidgets(
      'adds FilterSubmissionsStartTimeChanged to FilterSubmissionsBloc '
      'when start time text field is updated',
      (tester) async {
        await pumpApp(tester);
        await tester.enterText(find.byKey(starttime_key), starttime.toString());
        verify(
          () => filterSubmissionsBloc
              .add(FilterSubmissionsStartTimeChanged(starttime.toString())),
        ).called(1);
      },
    );

    testWidgets(
      'adds FilterSubmissionsEndTimeChanged to FilterSubmissionsBloc '
      'when end time text field is updated',
      (tester) async {
        await pumpApp(tester);
        await tester.enterText(find.byKey(endtime_key), endtime.toString());
        verify(
          () => filterSubmissionsBloc
              .add(FilterSubmissionsEndTimeChanged(endtime.toString())),
        ).called(1);
      },
    );

    testWidgets(
      'adds FilterSubmissionsMinScoreChanged to FilterSubmissionsBloc '
      'when min score text field is updated',
      (tester) async {
        await pumpApp(tester);
        await tester.enterText(find.byKey(minscore_key), minscore.toString());
        verify(
          () => filterSubmissionsBloc
              .add(FilterSubmissionsMinScoreChanged(minscore.toString())),
        ).called(1);
      },
    );

    testWidgets(
      'adds FilterSubmissionsMaxScoreChanged to FilterSubmissionsBloc '
      'when max score text field is updated',
      (tester) async {
        await pumpApp(tester);
        await tester.enterText(find.byKey(maxscore_key), maxscore.toString());
        verify(
          () => filterSubmissionsBloc
              .add(FilterSubmissionsMaxScoreChanged(maxscore.toString())),
        ).called(1);
      },
    );

    testWidgets(
      'adds SubmissionsLoadEvent with no parameters to SubmissionsBloc '
      'when filter button is pressed and all text fields are blank',
      (tester) async {
        await pumpApp(tester);
        await tester.tap(find.byKey(button_key));
        verify(
          () => submissionsBloc.add(SubmissionsLoadEvent()),
        ).called(1);
      },
    );

    testWidgets(
      'adds SubmissionsLoadEvent with contexts of text fields as parameters '
      'to SubmissionsBloc '
      'when filter button is pressed and all text fields are filled',
      (tester) async {
        when(() => filterSubmissionsBloc.state)
            .thenReturn(FilterSubmissionsState(
          starttime: starttime.toString(),
          endtime: endtime.toString(),
          minscore: minscore.toString(),
          maxscore: maxscore.toString(),
        ));
        await pumpApp(tester);
        /*await tester.enterText(find.byKey(starttime_key), starttime.toString());
        await tester.enterText(find.byKey(endtime_key), endtime.toString());
        await tester.enterText(find.byKey(minscore_key), minscore.toString());
        await tester.enterText(find.byKey(maxscore_key), maxscore.toString());*/
        await tester.tap(find.byKey(button_key));
        verify(
          () => submissionsBloc.add(SubmissionsLoadEvent(
            starttime: starttime,
            endtime: endtime,
            minscore: minscore,
            maxscore: maxscore,
          )),
        ).called(1);
      },
    );
  });
}
