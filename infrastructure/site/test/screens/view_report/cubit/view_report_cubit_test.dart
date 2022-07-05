import 'package:admin/models/RecentReport.dart';
import 'package:admin/screens/view_report/view_report.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ViewReportCubit', () {
    RecentReport placeholderReport = RecentReport();
    ViewReportCubit buildCubit() =>
        ViewReportCubit(fileInfo: placeholderReport);
    group('constructor', () {
      test('works properly', () {
        expect(buildCubit, returnsNormally);
      });

      test('has correct initial state', () {
        expect(
          buildCubit().state,
          equals(ViewReportState(fileInfo: placeholderReport)),
        );
      });
    });
  });
}
