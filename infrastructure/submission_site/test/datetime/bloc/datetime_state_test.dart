import 'package:flutter_test/flutter_test.dart';
import 'package:submission_site/datetime/datetime.dart';

void main() {
  group('DatetimeState', () {
    const int defaultYear = 2022;
    const Month defaultMonth = Month.august;
    const int defaultDay = 7;
    const int defaultHour = 19;
    const int defaultMinute = 27;
    const int defaultSecond = 1;

    test('supports value equality', () {
      expect(
        const DatetimeState(
          year: defaultYear,
          month: defaultMonth,
          day: defaultDay,
          hour: defaultHour,
          minute: defaultMinute,
          second: defaultSecond,
        ),
        equals(const DatetimeState(
          year: defaultYear,
          month: defaultMonth,
          day: defaultDay,
          hour: defaultHour,
          minute: defaultMinute,
          second: defaultSecond,
        )),
      );
    });

    test('props are correct', () {
      expect(
        const DatetimeState(
          year: defaultYear,
          month: defaultMonth,
          day: defaultDay,
          hour: defaultHour,
          minute: defaultMinute,
          second: defaultSecond,
        ).props,
        equals([
          defaultYear,
          defaultMonth,
          defaultDay,
          defaultHour,
          defaultMinute,
          defaultSecond
        ]),
      );
    });

    group('copyWith', () {
      test('returns state with same fields if no parameters are passed', () {
        expect(
          const DatetimeState(
            year: defaultYear,
            month: defaultMonth,
            day: defaultDay,
            hour: defaultHour,
            minute: defaultMinute,
            second: defaultSecond,
          ).copyWith(),
          equals(const DatetimeState(
            year: defaultYear,
            month: defaultMonth,
            day: defaultDay,
            hour: defaultHour,
            minute: defaultMinute,
            second: defaultSecond,
          )),
        );
      });

      test('returns state with same fields if all parameters are null', () {
        expect(
          const DatetimeState(
            year: defaultYear,
            month: defaultMonth,
            day: defaultDay,
            hour: defaultHour,
            minute: defaultMinute,
            second: defaultSecond,
          ).copyWith(
            year: null,
            month: null,
            day: null,
            hour: null,
            minute: null,
            second: null,
          ),
          equals(const DatetimeState(
            year: defaultYear,
            month: defaultMonth,
            day: defaultDay,
            hour: defaultHour,
            minute: defaultMinute,
            second: defaultSecond,
          )),
        );
      });

      test(
        'returns state with changed fields if all parameters are non-null',
        () {
          const int newYear = 2002;
          const Month newMonth = Month.april;
          const int newDay = 6;
          const int newHour = 8;
          const int newMinute = 0;
          const int newSecond = 0;

          expect(
            const DatetimeState(
              year: defaultYear,
              month: defaultMonth,
              day: defaultDay,
              hour: defaultHour,
              minute: defaultMinute,
              second: defaultSecond,
            ).copyWith(
              year: newYear,
              month: newMonth,
              day: newDay,
              hour: newHour,
              minute: newMinute,
              second: newSecond,
            ),
            equals(const DatetimeState(
              year: newYear,
              month: newMonth,
              day: newDay,
              hour: newHour,
              minute: newMinute,
              second: newSecond,
            )),
          );
        },
      );
    });

    test('fromTimestamp works correctly', () {
      expect(
        DatetimeState.fromTimestamp(1659900421),
        equals(const DatetimeState(
          year: defaultYear,
          month: defaultMonth,
          day: defaultDay,
          hour: defaultHour,
          minute: defaultMinute,
          second: defaultSecond,
        )),
      );
    });
  });
}
