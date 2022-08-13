import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission_site/datetime/datetime.dart';
import 'package:submission_site/home/home.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

class MockHomeEvent extends HomeEvent {}

void main() {
  group('DatetimeView', () {
    const int defaultTimestamp = 1657036800;
    final DatetimeBloc datetimeBloc = DatetimeBloc(defaultTimestamp);
    late HomeBloc homeBloc;
    late List<HomeEvent> eventsAdded;

    setUpAll(() {
      registerFallbackValue(MockHomeEvent());
    });

    setUp(() {
      homeBloc = MockHomeBloc();
      eventsAdded = [];
      when(() => homeBloc.stream).thenAnswer(
        (_) => const Stream<HomeState>.empty(),
      );
      when(() => homeBloc.add(any())).thenAnswer((invocation) {
        final List args = invocation.positionalArguments;
        eventsAdded.add(args[0]);
      });
    });

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<DatetimeBloc>.value(value: datetimeBloc),
            BlocProvider<HomeBloc>.value(value: homeBloc)
          ],
          child: const DatetimeView(),
        ),
      ));
    }

    group('renders', () {
      testWidgets('AppBar with correct title', (tester) async {
        await pumpApp(tester);
        expect(find.byType(AppBar), findsOneWidget);
        final AppBar appBar = tester.widget(find.byType(AppBar));
        final Text titleText = appBar.title as Text;
        expect(titleText.data, equals('Change date/time of submission?'));
      });

      testWidgets('all six dropdowns', (tester) async {
        await pumpApp(tester);
        expect(find.byType(YearDropdown), findsOneWidget);
        expect(find.byType(MonthDropdown), findsOneWidget);
        expect(find.byType(DayDropdown), findsOneWidget);
        expect(find.byType(HourDropdown), findsOneWidget);
        expect(find.byType(MinuteDropdown), findsOneWidget);
        expect(find.byType(SecondDropdown), findsOneWidget);
      });

      testWidgets(
        'dropdowns all in a row if display is desktop',
        (tester) async {
          // set view to desktop
          tester.binding.window.physicalSizeTestValue = const Size(3840, 2160);
          await pumpApp(tester);

          // dropdowns are children of a Row
          expect(find.byType(Column), findsOneWidget);
          final Column column = tester.widget(find.byType(Column));
          expect(column.children[0], isA<Row>());

          // colons are not centered
          for (Center center in tester.widgetList(find.byType(Center))) {
            expect(center, isNot(isA<Text>()));
          }

          // reset view size for other tests
          addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        },
      );

      testWidgets(
        'dropdowns in a Wrap widget if display is not desktop',
        (tester) async {
          // view is not desktop by default
          await pumpApp(tester);

          // dropdowns are children of a Wrap
          expect(find.byType(Column), findsOneWidget);
          final Column column = tester.widget(find.byType(Column));
          expect(column.children[0], isA<Wrap>());

          // colons are centered
          int centeredColons = 0;
          for (Center center in tester.widgetList(find.byType(Center))) {
            if (center.child.runtimeType == Text) {
              if ((center.child as Text).data == ':') {
                centeredColons++;
              }
            }
          }
          expect(centeredColons, equals(2));
        },
      );

      testWidgets('colons', (tester) async {
        await pumpApp(tester);
        expect(find.text(':'), findsNWidgets(2));
      });

      testWidgets('Cancel and OK buttons', (tester) async {
        await pumpApp(tester);
        expect(find.byType(ElevatedButton), findsNWidgets(2));
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('OK'), findsOneWidget);
      });
    });

    group('when Cancel button is pressed', () {
      testWidgets('DatetimeView is dismissed', (tester) async {
        await pumpApp(tester);
        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();
        expect(find.byType(DatetimeView), findsNothing);
      });

      testWidgets('no events are added to HomeBloc', (tester) async {
        await pumpApp(tester);
        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();
        expect(eventsAdded.isEmpty, isTrue);
      });
    });

    group('when OK button is pressed', () {
      testWidgets('DatetimeView is dismissed', (tester) async {
        await pumpApp(tester);
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
        expect(find.byType(DatetimeView), findsNothing);
      });

      testWidgets(
        'HomeTimestampChanged event is added to HomeBloc',
        (tester) async {
          await pumpApp(tester);
          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle();
          expect(eventsAdded.length, equals(1));
          expect(
            eventsAdded[0],
            equals(const HomeTimestampChanged(defaultTimestamp)),
          );
        },
      );
    });

    // TODO: test dropdowns' effect on other dropdowns
  });
}
