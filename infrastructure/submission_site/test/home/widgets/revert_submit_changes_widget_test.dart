import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission_site/home/home.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

class MockHomeEvent extends HomeEvent {}

void main() {
  group('RevertSubmitChangesWidget', () {
    late HomeBloc bloc;
    late List<HomeEvent> eventsAdded;

    setUpAll(() {
      registerFallbackValue(MockHomeEvent());
    });

    setUp(() {
      bloc = MockHomeBloc();
      eventsAdded = [];
      when(() => bloc.stream).thenAnswer(
        (_) => const Stream<HomeState>.empty(),
      );
      when(() => bloc.add(any())).thenAnswer((invocation) {
        final List args = invocation.positionalArguments;
        eventsAdded.add(args[0]);
      });
    });

    Future<void> pumpApp(WidgetTester tester, {bool enabled = true}) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider<HomeBloc>.value(
            value: bloc,
            child: RevertSubmitChangesWidget(enabled: enabled),
          ),
        ),
      ));
    }

    testWidgets(
      'renders two ElevatedButtons, each with correct text',
      (tester) async {
        await pumpApp(tester);
        expect(find.byType(ElevatedButton), findsNWidgets(2));
        expect(find.text('Revert Changes'), findsOneWidget);
        expect(find.text('Submit Changes'), findsOneWidget);
      },
    );

    testWidgets('buttons are disabled when enabled is false', (tester) async {
      await pumpApp(tester, enabled: false);
      final Iterable<ElevatedButton> buttons = tester.widgetList(
        find.byType(ElevatedButton),
      );
      expect(buttons.first.enabled, isFalse);
      expect(buttons.last.enabled, isFalse);
    });

    testWidgets('buttons are enabled when enabled is true', (tester) async {
      await pumpApp(tester, enabled: true);
      final Iterable<ElevatedButton> buttons = tester.widgetList(
        find.byType(ElevatedButton),
      );
      expect(buttons.first.enabled, isTrue);
      expect(buttons.last.enabled, isTrue);
    });

    testWidgets(
      'correct alert dialog appears when Revert Changes button is pressed',
      (tester) async {
        await pumpApp(tester);
        await tester.tap(find.text('Revert Changes'));
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(
          find.text('Are you sure you want to revert your changes?'),
          findsOneWidget,
        );
        expect(find.byType(TextButton), findsNWidgets(2));
        expect(find.text('No'), findsOneWidget);
        expect(find.text('Yes'), findsOneWidget);
      },
    );

    testWidgets(
      'Alert dialog disappears '
      'when No button in Revert Changes dialog is tapped',
      (tester) async {
        await pumpApp(tester);
        await tester.tap(find.text('Revert Changes'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('No'));
        await tester.pumpAndSettle();
        expect(eventsAdded.isEmpty, isTrue);
        expect(find.byType(AlertDialog), findsNothing);
      },
    );

    testWidgets(
      'HomeChangesReverted event is added and alert dialog disappears '
      'when Yes button in Revert Changes dialog is tapped',
      (tester) async {
        await pumpApp(tester);
        await tester.tap(find.text('Revert Changes'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Yes'));
        await tester.pumpAndSettle();
        expect(eventsAdded.length, equals(1));
        expect(eventsAdded[0], isA<HomeChangesReverted>());
        expect(find.byType(AlertDialog), findsNothing);
      },
    );

    testWidgets(
      'correct alert dialog appears when Submit Changes button is pressed',
      (tester) async {
        await pumpApp(tester);
        await tester.tap(find.text('Submit Changes'));
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(
          find.text('Are you sure you want to submit your changes?'),
          findsOneWidget,
        );
        expect(find.byType(TextButton), findsNWidgets(2));
        expect(find.text('No'), findsOneWidget);
        expect(find.text('Yes'), findsOneWidget);
      },
    );

    testWidgets(
      'Alert dialog disappears '
      'when No button in Submit Changes dialog is tapped',
      (tester) async {
        await pumpApp(tester);
        await tester.tap(find.text('Submit Changes'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('No'));
        await tester.pumpAndSettle();
        expect(eventsAdded.isEmpty, isTrue);
        expect(find.byType(AlertDialog), findsNothing);
      },
    );

    testWidgets(
      'HomeChangesSubmitted event is added and alert dialog disappears '
      'when Yes button in Submit Changes dialog is tapped',
      (tester) async {
        await pumpApp(tester);
        await tester.tap(find.text('Submit Changes'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Yes'));
        await tester.pumpAndSettle();
        expect(eventsAdded.length, equals(1));
        expect(eventsAdded[0], isA<HomeChangesSubmitted>());
        expect(find.byType(AlertDialog), findsNothing);
      },
    );
  });
}
