import 'package:flutter_test/flutter_test.dart';
import 'package:submission_site/datetime/datetime.dart';

void main() {
  group('DatetimeYearChanged', () {
    const int defaultYear = 2022;

    test('supports value equality', () {
      expect(
        const DatetimeYearChanged(defaultYear),
        equals(const DatetimeYearChanged(defaultYear)),
      );
    });

    test('props are correct', () {
      expect(
        const DatetimeYearChanged(defaultYear).props,
        equals([defaultYear]),
      );
    });
  });

  group('DatetimeMonthChanged', () {
    const Month defaultMonth = Month.august;

    test('supports value equality', () {
      expect(
        const DatetimeMonthChanged(defaultMonth),
        equals(const DatetimeMonthChanged(defaultMonth)),
      );
    });

    test('props are correct', () {
      expect(
        const DatetimeMonthChanged(defaultMonth).props,
        equals([defaultMonth]),
      );
    });
  });

  group('DatetimeDayChanged', () {
    const int defaultDay = 7;

    test('supports value equality', () {
      expect(
        const DatetimeDayChanged(defaultDay),
        equals(const DatetimeDayChanged(defaultDay)),
      );
    });

    test('props are correct', () {
      expect(
        const DatetimeDayChanged(defaultDay).props,
        equals([defaultDay]),
      );
    });
  });

  group('DatetimeHourChanged', () {
    const int defaultHour = 15;

    test('supports value equality', () {
      expect(
        const DatetimeHourChanged(defaultHour),
        equals(const DatetimeHourChanged(defaultHour)),
      );
    });

    test('props are correct', () {
      expect(
        const DatetimeHourChanged(defaultHour).props,
        equals([defaultHour]),
      );
    });
  });

  group('DatetimeMinuteChanged', () {
    const int defaultMinute = 27;

    test('supports value equality', () {
      expect(
        const DatetimeMinuteChanged(defaultMinute),
        equals(const DatetimeMinuteChanged(defaultMinute)),
      );
    });

    test('props are correct', () {
      expect(
        const DatetimeMinuteChanged(defaultMinute).props,
        equals([defaultMinute]),
      );
    });
  });

  group('DatetimeSecondChanged', () {
    const int defaultSecond = 2022;

    test('supports value equality', () {
      expect(
        const DatetimeSecondChanged(defaultSecond),
        equals(const DatetimeSecondChanged(defaultSecond)),
      );
    });

    test('props are correct', () {
      expect(
        const DatetimeSecondChanged(defaultSecond).props,
        equals([defaultSecond]),
      );
    });
  });
}
