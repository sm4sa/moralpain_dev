import 'package:admin/models/RecentReport.dart';
import 'package:admin/screens/view_report/cubit/view_report_cubit.dart';
import 'package:admin/screens/view_report/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String title = 'title';
  String date = 'date';
  final RecentReport nullTitleAndDateReport = RecentReport(
    icon: 'assets/icons/doc_file.svg',
  );
  final RecentReport nonNullTitleAndDateReport = RecentReport(
    icon: 'assets/icons/doc_file.svg',
    title: title,
    date: date,
  );

  Future<void> pumpWidget({
    required WidgetTester tester,
    required Widget widget,
    RecentReport? fileInfo,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ViewReportCubit>(
          create: (context) => ViewReportCubit(fileInfo: fileInfo),
          child: widget,
        ),
      ),
    );
  }

  group('ViewReportPage', () {
    testWidgets('renders ViewReportView', (tester) async {
      await pumpWidget(
        tester: tester,
        widget: ViewReportView(),
      );
      expect(find.byType(ViewReportView), findsOneWidget);
    });
  });

  group('ViewReportView', () {
    group('if fileInfo is null', () {
      testWidgets('renders AppBar with correct title and no other text',
          (tester) async {
        await pumpWidget(
          tester: tester,
          widget: ViewReportView(),
        );
        // Verify that there is one AppBar
        expect(find.byType(AppBar), findsOneWidget);

        // Verify that the AppBar has the right text
        expect(
          tester.widget<AppBar>(find.byType(AppBar)),
          isA<AppBar>().having(
            (p0) => (p0.title as Text).data,
            'Text data',
            equals('No report to view.'),
          ),
        );

        // Verify that the text in the AppBar is the only text
        expect(find.byType(Text), findsOneWidget);
      });
    });

    group('if fileInfo isn\'t null', () {
      group('and if fileInfo title is null', () {
        testWidgets(
          'renders AppBar with title saying the fileInfo has no title',
          (tester) async {
            await pumpWidget(
              tester: tester,
              widget: ViewReportView(),
              fileInfo: nullTitleAndDateReport,
            );
            // Verify that there is one AppBar
            expect(find.byType(AppBar), findsOneWidget);

            // Verify that the AppBar has the right text
            expect(
              tester.widget<AppBar>(find.byType(AppBar)),
              isA<AppBar>().having(
                (p0) => (p0.title as Text).data,
                'Text data',
                equals('No title for this report.'),
              ),
            );
          },
        );
      });

      group('and if fileInfo title isn\'t null', () {
        testWidgets('renders AppBar with fileInfo title', (tester) async {
          await pumpWidget(
            tester: tester,
            widget: ViewReportView(),
            fileInfo: nonNullTitleAndDateReport,
          );
          // Verify that there is one AppBar
          expect(find.byType(AppBar), findsOneWidget);

          // Verify that the AppBar has the right text
          expect(
            tester.widget<AppBar>(find.byType(AppBar)),
            isA<AppBar>().having(
              (p0) => (p0.title as Text).data,
              'Text data',
              equals(title),
            ),
          );
        });
      });

      group('and fileInfo date is null', () {
        testWidgets('has text in body saying the fileInfo has no date',
            (tester) async {
          await pumpWidget(
            tester: tester,
            widget: ViewReportView(),
            fileInfo: nullTitleAndDateReport,
          );
          expect(find.text('No date for this report.'), findsOneWidget);
        });
      });

      group('and fileInfo date isn\'t null', () {
        testWidgets('has fileInfo date in body', (tester) async {
          await pumpWidget(
            tester: tester,
            widget: ViewReportView(),
            fileInfo: nonNullTitleAndDateReport,
          );
          expect(find.text(date), findsOneWidget);
        });
      });
    });
  });
}
