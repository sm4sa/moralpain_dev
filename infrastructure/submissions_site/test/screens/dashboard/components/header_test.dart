import 'package:submissions_site/controllers/MenuController.dart';
import 'package:submissions_site/screens/dashboard/components/header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockMenuController extends Mock implements MenuController {}

void main() {
  late MenuController controller;

  setUp(() {
    controller = MockMenuController();
    when(() => controller.controlMenu()).thenAnswer((_) {});
  });

  group('Header', () {
    final titleText = 'MoralPain Admin Dashboard';

    group('renders', () {
      testWidgets('drawer icon when not on desktop', (tester) async {
        await pumpWidget(tester, Header());
        expect(find.byIcon(Icons.menu), findsOneWidget);

        setTablet(tester);
        expect(find.byIcon(Icons.menu), findsOneWidget);
      });

      testWidgets('no drawer icon when on desktop', (tester) async {
        setDesktop(tester);
        await pumpWidget(tester, Header());
        expect(find.byIcon(Icons.menu), findsNothing);
      });

      testWidgets('title text when not on mobile', (tester) async {
        setTablet(tester);
        await pumpWidget(tester, Header());
        expect(find.text(titleText), findsOneWidget);

        setDesktop(tester);
        expect(find.text(titleText), findsOneWidget);
      });

      testWidgets('no title text when on mobile', (tester) async {
        await pumpWidget(tester, Header());
        expect(find.text(titleText), findsNothing);
      });

      testWidgets('no Spacer when on mobile', (tester) async {
        await pumpWidget(tester, Header());
        expect(find.byType(Spacer), findsNothing);
      });

      testWidgets('Spacer with flex 1 when on tablet', (tester) async {
        setTablet(tester);
        await pumpWidget(tester, Header());
        expect(find.byType(Spacer), findsOneWidget);

        Spacer spacer = tester.widget<Spacer>(find.byType(Spacer));
        expect(
          spacer,
          isA<Spacer>().having(
            (spacer) => spacer.flex,
            'flex',
            equals(1),
          ),
        );
      });

      testWidgets('Spacer with flex 2 when on desktop', (tester) async {
        setDesktop(tester);
        await pumpWidget(tester, Header());
        expect(find.byType(Spacer), findsOneWidget);

        Spacer spacer = tester.widget<Spacer>(find.byType(Spacer));
        expect(
          spacer,
          isA<Spacer>().having(
            (spacer) => spacer.flex,
            'flex',
            equals(2),
          ),
        );
      });

      testWidgets('SearchField', (tester) async {
        await pumpWidget(tester, Header());
        expect(find.byType(SearchField), findsOneWidget);
      });

      testWidgets('ProfileCard', (tester) async {
        await pumpWidget(tester, Header());
        expect(find.byType(ProfileCard), findsOneWidget);
      });
    });

    testWidgets('controlMenu is called when drawer icon is pressed',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => controller,
              ),
            ],
            child: Scaffold(
              body: Header(),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(IconButton));
      verify(() => controller.controlMenu()).called(1);
    });
  });

  group('ProfileCard', () {
    group('renders', () {
      final username = 'Alan Turing';
      final profilePic = 'assets/icons/font-awesome/user-solid.svg';

      testWidgets('correct user icon', (tester) async {
        await pumpWidget(tester, ProfileCard());
        expect(find.byType(SvgPicture), findsOneWidget);

        SvgPicture svgPicture =
            tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(
          svgPicture,
          isA<SvgPicture>().having(
            (svgPicture) =>
                (svgPicture.pictureProvider as ExactAssetPicture).assetName,
            'assetName',
            equals(profilePic),
          ),
        );
      });

      testWidgets('correct username if not on mobile', (tester) async {
        setTablet(tester);
        await pumpWidget(tester, ProfileCard());
        expect(find.text(username), findsOneWidget);

        setDesktop(tester);
        expect(find.text(username), findsOneWidget);
      });

      testWidgets('dropdown icon', (tester) async {
        await pumpWidget(tester, ProfileCard());
        expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
      });
    });
  });

  group('SearchField', () {
    final String hintText = 'Search';
    final String searchIcon = 'assets/icons/Search.svg';

    testWidgets('has correct hint text', (tester) async {
      await pumpWidget(tester, SearchField());
      TextField textField = tester.widget<TextField>(find.byType(TextField));
      expect(
        textField,
        isA<TextField>().having(
          (field) => field.decoration!.hintText,
          'hintText',
          equals(hintText),
        ),
      );
    });

    testWidgets('renders correct icon', (tester) async {
      await pumpWidget(tester, SearchField());
      expect(find.byType(SvgPicture), findsOneWidget);

      SvgPicture svgPicture =
          tester.widget<SvgPicture>(find.byType(SvgPicture));
      expect(
        svgPicture,
        isA<SvgPicture>().having(
          (svgPicture) =>
              (svgPicture.pictureProvider as ExactAssetPicture).assetName,
          'assetName',
          equals(searchIcon),
        ),
      );
    });
  });
}

Future<void> pumpWidget(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: Scaffold(
          body: widget,
        ),
      ),
    ),
  );
}

void setTablet(WidgetTester tester) {
  tester.binding.window.physicalSizeTestValue = Size(1000, 2160);
  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
}

void setDesktop(WidgetTester tester) {
  tester.binding.window.physicalSizeTestValue = Size(3840, 2160);
  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
}
