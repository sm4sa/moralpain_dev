import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moraldistress/assets/constants.dart' as Constants;
import 'package:moraldistress/thermometer/cubit/thermometer_cubit.dart';
import 'package:moraldistress/thermometer/view/thermometer_view.dart';

void main() {
  group('ThermometerView', () {
    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
          create: (_) => ThermometerCubit(),
          child: ThermometerView(),
        ),
      ));
    }

    group('renders', () {
      testWidgets('AppBar with correct title', (tester) async {
        await pumpApp(tester);
        expect(find.byType(AppBar), findsOneWidget);
        AppBar appBar = tester.widget(find.byType(AppBar));
        expect(appBar.title, isNotNull);
        expect(appBar.title, isA<Text>());
        Text title = appBar.title as Text;
        expect(title.data, equals(Constants.APPBAR_TEXT));
      });

      testWidgets('OrientationBuilder', (tester) async {
        await pumpApp(tester);
        expect(find.byType(OrientationBuilder), findsOneWidget);
      });

      testWidgets(
        'a single Column and no Rows if in portrait mode',
        (tester) async {
          tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
          await pumpApp(tester);
          expect(find.byType(Column), findsOneWidget);
          expect(find.byType(Row), findsNothing);
        },
      );

      testWidgets(
        'a Row with a Column child that has a Column child '
        'and a BlocBuilder child if in landscape mode',
        (tester) async {
          // There is one Row
          tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
          await pumpApp(tester);
          expect(find.byType(Row), findsOneWidget);

          // Row has two children with type Expanded
          Row row = tester.widget(find.byType(Row));
          Iterable<Widget> rowChildren = row.children.where(
            (child) => child.runtimeType == Expanded,
          );
          expect(rowChildren.length, equals(2));

          // One of the Row's children has a child of type Column
          rowChildren = rowChildren.where(
            (expanded) => (expanded as Expanded).child.runtimeType == Column,
          );
          expect(rowChildren.length, equals(1));

          // The child of type Column has one child of type Column
          Column column = (rowChildren.first as Expanded).child as Column;
          Iterable<Widget> columnChildren = column.children.where(
            (child) => child.runtimeType == Column,
          );
          expect(columnChildren.length, equals(1));

          // The child of type Column has one child of type BlocBuilder
          columnChildren = column.children.where(
            (child) =>
                child.runtimeType == BlocBuilder<ThermometerCubit, double>,
          );
        },
      );

      testWidgets('"next" button with correct icon', (tester) async {
        await pumpApp(tester);
        expect(find.byType(FloatingActionButton), findsOneWidget);
        FloatingActionButton button = tester.widget(
          find.byType(FloatingActionButton),
        );
        expect(button.child, isA<Icon>());
        Icon icon = button.child as Icon;
        expect(icon.icon, equals(Icons.navigate_next));
      });
    });
  });
}
