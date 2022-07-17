import 'package:analytics_site/models/RecentReport.dart';
import 'package:analytics_site/screens/view_report/cubit/view_report_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ViewReportState', () {
    final RecentReport fileInfo = RecentReport();

    test('supports equality', () {
      expect(ViewReportState(), equals(ViewReportState()));
      expect(
        ViewReportState(fileInfo: fileInfo),
        equals(ViewReportState(fileInfo: fileInfo)),
      );
    });

    test('props are correct', () {
      expect(ViewReportState().props, equals(<Object?>[null]));
      expect(
        ViewReportState(fileInfo: fileInfo).props,
        equals(<Object?>[fileInfo]),
      );
    });
  });
}
