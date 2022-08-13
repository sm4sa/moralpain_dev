import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_site/datetime/datetime.dart';

class TestDropdown extends Dropdown {
  TestDropdown({Key? key}) : super(key: key);

  @override
  DropdownButtonFormField buildFormField(BuildContext context) {
    return DropdownButtonFormField<int>(
      items: const [
        DropdownMenuItem(child: Text('dropdown item')),
      ],
      onChanged: (_) {},
    );
  }
}

void main() {
  group('Dropdown', () {
    bool isDesktop(WidgetTester tester) =>
        tester.binding.window.physicalSize.width > 1100;

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: isDesktop(tester)
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [TestDropdown()],
                  )
                : Wrap(
                    children: [TestDropdown()],
                  )),
      ));
    }

    group('renders', () {
      testWidgets('buildFormField', (tester) async {
        // set view to non-desktop
        tester.binding.window.physicalSizeTestValue = const Size(960, 540);
        await pumpApp(tester);

        expect(find.byType(DropdownButtonFormField<int>), findsOneWidget);
        expect(find.byType(DropdownMenuItem<int>), findsOneWidget);
        expect(find.text('dropdown item'), findsOneWidget);

        // reset view size for other tests
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      });

      testWidgets('Flex widget if not on desktop', (tester) async {
        // set view to non-desktop
        tester.binding.window.physicalSizeTestValue = const Size(960, 540);

        await pumpApp(tester);
        expect(find.byType(Flex), findsOneWidget);

        // reset view size for other tests
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      });

      testWidgets('no Flex widget if on desktop', (tester) async {
        // set view to desktop
        tester.binding.window.physicalSizeTestValue = const Size(3840, 2160);

        await pumpApp(tester);
        expect(find.byType(Flex), findsNothing);

        // reset view size for other tests
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      });
    });
  });
}
