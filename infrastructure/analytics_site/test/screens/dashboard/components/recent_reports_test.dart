import 'package:analytics_site/models/RecentReport.dart';
import 'package:analytics_site/screens/dashboard/components/recent_reports.dart';
import 'package:analytics_site/screens/view_report/view/view.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setUpAll(() {
    registerFallbackValue(MaterialPageRoute<dynamic>(
      builder: (context) {
        return Scaffold();
      },
    ));
  });

  group('RecentReports', () {
    group('renders', () {
      testWidgets('data table', (tester) async {
        await pumpRecentReports(tester);
        expect(find.byType(DataTable2), findsOneWidget);
      });

      testWidgets('DataRow for every recent report', (tester) async {
        await pumpRecentReports(tester);
        DataTable2 table = tester.widget<DataTable2>(find.byType(DataTable2));
        expect(table.rows.length, equals(demoRecentReports.length));
      });
    });
  });

  group('recentReportsDataRow', () {
    final rowIcon = 'assets/icons/font-awesome/calendar-day-solid.svg';
    final rowTitle = 'title';
    final rowDate = '06-24-2022';
    final RecentReport fileInfo = RecentReport(
      icon: rowIcon,
      title: rowTitle,
      date: rowDate,
    );

    final observer = MockNavigatorObserver();

    Future<void> pumpRecentReportsDataRow({
      required WidgetTester tester,
      required RecentReport fileInfo,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RecentReportsDataRowScaffold(
            fileInfo: fileInfo,
          ),
          navigatorObservers: [observer],
        ),
      );
    }

    group('renders', () {
      testWidgets('correct icon', (tester) async {
        await pumpRecentReportsDataRow(
          tester: tester,
          fileInfo: fileInfo,
        );
        expect(find.byType(SvgPicture), findsOneWidget);

        expect(
          tester.widget<SvgPicture>(find.byType(SvgPicture)),
          isA<SvgPicture>().having(
            (svgPicture) =>
                (svgPicture.pictureProvider as ExactAssetPicture).assetName,
            'assetName',
            equals(rowIcon),
          ),
        );
      });

      testWidgets('correct title', (tester) async {
        await pumpRecentReportsDataRow(
          tester: tester,
          fileInfo: fileInfo,
        );
        expect(find.text(rowTitle), findsOneWidget);
      });

      testWidgets('correct date', (tester) async {
        await pumpRecentReportsDataRow(
          tester: tester,
          fileInfo: fileInfo,
        );
        expect(find.text(rowDate), findsOneWidget);
      });
    });

    testWidgets('ViewReportPage is displayed when DataRow is tapped',
        (tester) async {
      await pumpRecentReportsDataRow(
        tester: tester,
        fileInfo: fileInfo,
      );
      await tester.tap(find.text(rowTitle));
      await tester.pumpAndSettle();

      // Verify that a push to the navigator happened
      verify(() => observer.didPush(
          any(
            that: isA<MaterialPageRoute<void>>().having(
              (route) => route.fullscreenDialog,
              'fullscreenDialog',
              isTrue,
            ),
          ),
          any())).called(1);

      // Verify that a ViewReportPage is now showing
      expect(find.byType(ViewReportPage), findsOneWidget);
    });
  });
}

class RecentReportsDataRowScaffold extends StatelessWidget {
  RecentReportsDataRowScaffold({Key? key, required this.fileInfo})
      : super(key: key);

  final RecentReport fileInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataTable2(
        columns: [
          DataColumn(label: Text('1')),
          DataColumn(label: Text('2')),
        ],
        rows: [recentReportDataRow(context, fileInfo)],
      ),
    );
  }
}

Future<void> pumpRecentReports(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: RecentReports(),
      ),
    ),
  );
}
