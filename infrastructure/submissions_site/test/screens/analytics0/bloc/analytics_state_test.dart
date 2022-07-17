import 'package:submissions_site/screens/analytics0/analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moralpainapi/moralpainapi.dart';

void main() {
  group('AnalyticsInitial', () {
    test('constructor completes normally', () {
      expect(() => const AnalyticsInitial(), returnsNormally);
    });

    test('supports value equality', () {
      expect(const AnalyticsInitial(), equals(const AnalyticsInitial()));
    });

    test('props are correct', () {
      expect(AnalyticsInitial().props, equals([]));
    });
  });

  group('AnalyticsInProgress', () {
    test('constructor completes normally', () {
      expect(() => const AnalyticsInProgress(), returnsNormally);
    });

    test('supports value equality', () {
      expect(const AnalyticsInProgress(), equals(const AnalyticsInProgress()));
    });

    test('props are correct', () {
      expect(AnalyticsInProgress().props, equals([]));
    });
  });

  group('AnalyticsSuccess', () {
    final AnalyticsResult result = AnalyticsResult();

    test('constructor completes normally', () {
      expect(() => AnalyticsSuccess(result), returnsNormally);
    });

    test('supports value equality', () {
      expect(AnalyticsSuccess(result), equals(AnalyticsSuccess(result)));
    });

    test('props are correct', () {
      expect(AnalyticsSuccess(result).props, equals([result]));
    });
  });

  group('AnalyticsFailure', () {
    test('constructor completes normally', () {
      expect(() => const AnalyticsFailure(), returnsNormally);
    });

    test('supports value equality', () {
      expect(const AnalyticsFailure(), equals(const AnalyticsFailure()));
    });

    test('props are correct', () {
      expect(AnalyticsFailure().props, equals([]));
    });
  });
}
