import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_site/datetime/datetime.dart';

void main() {
  group('YearDropdown', () {
    late DatetimeBloc bloc;

    setUp(() => bloc = DatetimeBloc(1657036800));

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider<DatetimeBloc>.value(
            value: bloc,
            child: YearDropdown(),
          ),
        ),
      ));
    }

    testWidgets('has menu items from 1970 to the current year', (tester) async {
      await pumpApp(tester);
      final DropdownButtonFormField<int> formField =
          tester.widget(find.byType(DropdownButtonFormField<int>));
      for (int year = 1970; year <= DateTime.now().year; year++) {
        expect(find.text('$year'), findsOneWidget);
      }
    });

    testWidgets('starts with same value as DatetimeBloc', (tester) async {
      await pumpApp(tester);
      final DropdownButtonFormField<int> formField =
          tester.widget(find.byType(DropdownButtonFormField<int>));
      expect(formField.initialValue, equals(2022));
    });

    testWidgets(
      'selecting a new value changes the year in DatetimeBloc',
      (tester) async {
        const int newYear = 1984;

        await pumpApp(tester);

        final dropdown = find.byType(DropdownButtonFormField<int>);
        await tester.tap(dropdown);
        await tester.pumpAndSettle();

        final dropdownItemFinder =
            find.byKey(const Key('yearDropdown_${newYear}_dropdownMenuItem'));
        final dropdownItem = tester.widget(dropdownItemFinder);
        print(dropdownItem);
        await tester.tap(dropdownItemFinder);
        await tester.pumpAndSettle();

        expect(bloc.state.year, equals(newYear));
      },
    );
  });
}
