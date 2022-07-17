import 'package:submissions_site/screens/analytics0/analytics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnalyticsStarted', () {
    const String operation = 'minimum';
    const int? starttime = 0;
    const int? endtime = null;

    AnalyticsStarted buildEvent() {
      return const AnalyticsStarted(
        operation: operation,
        starttime: starttime,
        endtime: endtime,
      );
    }

    test('constructor completes normally', () {
      expect(buildEvent, returnsNormally);
    });

    test('supports value equality', () {
      expect(buildEvent(), equals(buildEvent()));
    });

    test('props are correct', () {
      expect(buildEvent().props, equals([operation, starttime, endtime]));
    });
  });
}
