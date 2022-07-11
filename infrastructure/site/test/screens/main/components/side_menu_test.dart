import 'package:admin/screens/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SideMenu', () {
    testWidgets('Renders a DrawerHeader with an svg image', (tester) async {
      await tester.pumpWidget(MaterialApp(home: SideMenu()));
      expect(find.byType(DrawerHeader), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(DrawerHeader),
          matching: find.byType(SvgPicture),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Renders three DrawerListTiles', (tester) async {
      await tester.pumpWidget(MaterialApp(home: SideMenu()));
      expect(find.byType(DrawerListTile), findsNWidgets(3));
    });
  });

  group('DrawerListTile', () {
    bool pressCalled = false;
    final tileTitle = 'title';
    final tileSvgSrc = 'assets/icons/doc_file.svg';
    final DrawerListTile tile = DrawerListTile(
      title: tileTitle,
      svgSrc: tileSvgSrc,
      press: () {
        pressCalled = true;
      },
    );

    testWidgets('renders an SvgPicture with correct image', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: tile,
          ),
        ),
      );
      expect(find.byType(SvgPicture), findsOneWidget);

      SvgPicture svgPicture =
          tester.widget<SvgPicture>(find.byType(SvgPicture));
      ExactAssetPicture svgPictureProvider =
          svgPicture.pictureProvider as ExactAssetPicture;
      expect(
        svgPictureProvider.assetName,
        equals(tileSvgSrc),
      );
    });

    testWidgets('renders the correct text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: tile,
          ),
        ),
      );
      expect(find.text(tileTitle), findsOneWidget);
    });

    testWidgets('calls press when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: tile,
          ),
        ),
      );
      await tester.tap(find.byType(DrawerListTile));
      expect(pressCalled, isTrue);
    });
  });
}
