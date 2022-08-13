import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_site/home/home.dart';

void main() {
  group('FieldDisplay', () {
    const String text = 'FieldDisplay text';
    late bool editButtonPressed;

    Future<void> pumpApp(WidgetTester tester, {Key? key}) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FieldDisplay(
              key: key,
              text: text,
              onPressed: () => editButtonPressed = true,
            ),
          ),
        ),
      );
    }

    setUp(() => editButtonPressed = false);

    testWidgets('renders text and edit button', (tester) async {
      await pumpApp(tester);
      expect(find.text(text), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets(
      'edit button has no key if FieldDisplay has no key',
      (tester) async {
        await pumpApp(tester);
        final editButton = tester.widget(find.byIcon(Icons.edit));
        expect(editButton.key, isNull);
      },
    );

    testWidgets(
      'edit button has no key if FieldDisplay key has no underscore',
      (tester) async {
        await pumpApp(tester, key: const Key('keyWithNoUnderscore'));
        final editButton = tester.widget(find.byIcon(Icons.edit));
        expect(editButton.key, isNull);
      },
    );

    testWidgets(
      'edit button has correct key if FieldDisplay key has underscore',
      (tester) async {
        await pumpApp(tester, key: const Key('testScaffold_test_fieldDisplay'));
        expect(
          find.byKey(const Key('fieldDisplay_test_iconButton')),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'onPressed is called when edit button is tapped',
      (tester) async {
        await pumpApp(tester);
        await tester.tap(find.byIcon(Icons.edit));
        expect(editButtonPressed, isTrue);
      },
    );

    testWidgets(
      'onPressed is not called when edit button is not tapped',
      (tester) async {
        await pumpApp(tester);
        expect(editButtonPressed, isFalse);
      },
    );
  });
}
