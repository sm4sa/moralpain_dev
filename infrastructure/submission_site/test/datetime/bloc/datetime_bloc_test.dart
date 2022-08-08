import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_site/datetime/datetime.dart';

void main() {
  group('Month', () {
    group('toString returns correct value for', () {
      test('Month.january', () {
        expect(Month.january.toString(), equals('January'));
      });

      test('Month.february', () {
        expect(Month.february.toString(), equals('February'));
      });

      test('Month.march', () {
        expect(Month.march.toString(), equals('March'));
      });

      test('Month.april', () {
        expect(Month.april.toString(), equals('April'));
      });

      test('Month.may', () {
        expect(Month.may.toString(), equals('May'));
      });

      test('Month.june', () {
        expect(Month.june.toString(), equals('June'));
      });

      test('Month.july', () {
        expect(Month.july.toString(), equals('July'));
      });

      test('Month.august', () {
        expect(Month.august.toString(), equals('August'));
      });

      test('Month.september', () {
        expect(Month.september.toString(), equals('September'));
      });

      test('Month.october', () {
        expect(Month.october.toString(), equals('October'));
      });

      test('Month.november', () {
        expect(Month.november.toString(), equals('November'));
      });

      test('Month.december', () {
        expect(Month.december.toString(), equals('December'));
      });
    });

    group('toInt returns correct value for', () {
      test('Month.january', () {
        expect(Month.january.toInt(), equals(1));
      });

      test('Month.february', () {
        expect(Month.february.toInt(), equals(2));
      });

      test('Month.march', () {
        expect(Month.march.toInt(), equals(3));
      });

      test('Month.april', () {
        expect(Month.april.toInt(), equals(4));
      });

      test('Month.may', () {
        expect(Month.may.toInt(), equals(5));
      });

      test('Month.june', () {
        expect(Month.june.toInt(), equals(6));
      });

      test('Month.july', () {
        expect(Month.july.toInt(), equals(7));
      });

      test('Month.august', () {
        expect(Month.august.toInt(), equals(8));
      });

      test('Month.september', () {
        expect(Month.september.toInt(), equals(9));
      });

      test('Month.october', () {
        expect(Month.october.toInt(), equals(10));
      });

      test('Month.november', () {
        expect(Month.november.toInt(), equals(11));
      });

      test('Month.december', () {
        expect(Month.december.toInt(), equals(12));
      });
    });

    group('numberOfDays returns correct value for', () {
      const int leapYear = 2020;
      const int nonLeapYear = 2021;

      group('Month.january', () {
        test('if year is leap year', () {
          expect(Month.january.numberOfDays(leapYear), equals(31));
        });

        test('if year is not leap year', () {
          expect(Month.january.numberOfDays(nonLeapYear), equals(31));
        });
      });

      group('Month.february', () {
        test('if year is leap year', () {
          expect(Month.february.numberOfDays(leapYear), equals(29));
        });

        test('if year is not leap year', () {
          expect(Month.february.numberOfDays(nonLeapYear), equals(28));
        });
      });

      group('Month.march', () {
        test('if year is leap year', () {
          expect(Month.march.numberOfDays(leapYear), equals(31));
        });

        test('if year is not leap year', () {
          expect(Month.march.numberOfDays(nonLeapYear), equals(31));
        });
      });

      group('Month.april', () {
        test('if year is leap year', () {
          expect(Month.april.numberOfDays(leapYear), equals(30));
        });

        test('if year is not leap year', () {
          expect(Month.april.numberOfDays(nonLeapYear), equals(30));
        });
      });

      group('Month.may', () {
        test('if year is leap year', () {
          expect(Month.may.numberOfDays(leapYear), equals(31));
        });

        test('if year is not leap year', () {
          expect(Month.may.numberOfDays(nonLeapYear), equals(31));
        });
      });

      group('Month.june', () {
        test('if year is leap year', () {
          expect(Month.june.numberOfDays(leapYear), equals(30));
        });

        test('if year is not leap year', () {
          expect(Month.june.numberOfDays(nonLeapYear), equals(30));
        });
      });

      group('Month.july', () {
        test('if year is leap year', () {
          expect(Month.july.numberOfDays(leapYear), equals(31));
        });

        test('if year is not leap year', () {
          expect(Month.july.numberOfDays(nonLeapYear), equals(31));
        });
      });

      group('Month.august', () {
        test('if year is leap year', () {
          expect(Month.august.numberOfDays(leapYear), equals(31));
        });

        test('if year is not leap year', () {
          expect(Month.august.numberOfDays(nonLeapYear), equals(31));
        });
      });

      group('Month.september', () {
        test('if year is leap year', () {
          expect(Month.september.numberOfDays(leapYear), equals(30));
        });

        test('if year is not leap year', () {
          expect(Month.september.numberOfDays(nonLeapYear), equals(30));
        });
      });

      group('Month.october', () {
        test('if year is leap year', () {
          expect(Month.october.numberOfDays(leapYear), equals(31));
        });

        test('if year is not leap year', () {
          expect(Month.october.numberOfDays(nonLeapYear), equals(31));
        });
      });

      group('Month.november', () {
        test('if year is leap year', () {
          expect(Month.november.numberOfDays(leapYear), equals(30));
        });

        test('if year is not leap year', () {
          expect(Month.november.numberOfDays(nonLeapYear), equals(30));
        });
      });

      group('Month.december', () {
        test('if year is leap year', () {
          expect(Month.december.numberOfDays(leapYear), equals(31));
        });

        test('if year is not leap year', () {
          expect(Month.december.numberOfDays(nonLeapYear), equals(31));
        });
      });
    });

    group('fromInt()', () {
      group('returns correct value for', () {
        test('1', () {
          expect(Month.fromInt(1), equals(Month.january));
        });

        test('2', () {
          expect(Month.fromInt(2), equals(Month.february));
        });

        test('3', () {
          expect(Month.fromInt(3), equals(Month.march));
        });

        test('4', () {
          expect(Month.fromInt(4), equals(Month.april));
        });

        test('5', () {
          expect(Month.fromInt(5), equals(Month.may));
        });

        test('6', () {
          expect(Month.fromInt(6), equals(Month.june));
        });

        test('7', () {
          expect(Month.fromInt(7), equals(Month.july));
        });

        test('8', () {
          expect(Month.fromInt(8), equals(Month.august));
        });

        test('9', () {
          expect(Month.fromInt(9), equals(Month.september));
        });

        test('10', () {
          expect(Month.fromInt(10), equals(Month.october));
        });

        test('11', () {
          expect(Month.fromInt(11), equals(Month.november));
        });

        test('12', () {
          expect(Month.fromInt(12), equals(Month.december));
        });
      });

      group('throws error for', () {
        test('value less than 1', () {
          expect(() => Month.fromInt(0), throwsA(isA<AssertionError>()));
        });

        test('value greater than 12', () {
          expect(() => Month.fromInt(13), throwsA(isA<AssertionError>()));
        });
      });
    });
  });

  group('DatetimeBloc', () {
    const int defaultTimestamp = 1657036800;
    const int defaultYear = 2022;
    const Month defaultMonth = Month.july;
    const int defaultDay = 5;
    const int defaultHour = 16;
    const int defaultMinute = 0;
    const int defaultSecond = 0;

    DatetimeBloc buildBloc() => DatetimeBloc(defaultTimestamp);

    group('constructor', () {
      test('works properly', () {
        expect(buildBloc, returnsNormally);
      });

      test('has correct initial state', () {
        expect(
          buildBloc().state,
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

    group('YearChanged', () {
      const int newYear = 2002;

      blocTest<DatetimeBloc, DatetimeState>(
        'emits state with updated year',
        build: buildBloc,
        act: (bloc) => bloc.add(const DatetimeYearChanged(newYear)),
        expect: () => [
          const DatetimeState(
            year: newYear,
            month: defaultMonth,
            day: defaultDay,
            hour: defaultHour,
            minute: defaultMinute,
            second: defaultSecond,
          ),
        ],
      );
    });

    group('MonthChanged', () {
      const Month newMonth = Month.april;

      blocTest<DatetimeBloc, DatetimeState>(
        'emits state with updated month',
        build: buildBloc,
        act: (bloc) => bloc.add(const DatetimeMonthChanged(newMonth)),
        expect: () => [
          const DatetimeState(
            year: defaultYear,
            month: newMonth,
            day: defaultDay,
            hour: defaultHour,
            minute: defaultMinute,
            second: defaultSecond,
          ),
        ],
      );
    });

    group('DayChanged', () {
      const int newDay = 6;

      blocTest<DatetimeBloc, DatetimeState>(
        'emits state with updated day',
        build: buildBloc,
        act: (bloc) => bloc.add(const DatetimeDayChanged(newDay)),
        expect: () => [
          const DatetimeState(
            year: defaultYear,
            month: defaultMonth,
            day: newDay,
            hour: defaultHour,
            minute: defaultMinute,
            second: defaultSecond,
          ),
        ],
      );
    });

    group('HourChanged', () {
      const int newHour = 4;

      blocTest<DatetimeBloc, DatetimeState>(
        'emits state with updated hour',
        build: buildBloc,
        act: (bloc) => bloc.add(const DatetimeHourChanged(newHour)),
        expect: () => [
          const DatetimeState(
            year: defaultYear,
            month: defaultMonth,
            day: defaultDay,
            hour: newHour,
            minute: defaultMinute,
            second: defaultSecond,
          ),
        ],
      );
    });

    group('MinuteChanged', () {
      const int newMinute = 20;

      blocTest<DatetimeBloc, DatetimeState>(
        'emits state with updated minute',
        build: buildBloc,
        act: (bloc) => bloc.add(const DatetimeMinuteChanged(newMinute)),
        expect: () => [
          const DatetimeState(
            year: defaultYear,
            month: defaultMonth,
            day: defaultDay,
            hour: defaultHour,
            minute: newMinute,
            second: defaultSecond,
          ),
        ],
      );
    });

    group('SecondChanged', () {
      const int newSecond = 59;

      blocTest<DatetimeBloc, DatetimeState>(
        'emits state with updated second',
        build: buildBloc,
        act: (bloc) => bloc.add(const DatetimeSecondChanged(newSecond)),
        expect: () => [
          const DatetimeState(
            year: defaultYear,
            month: defaultMonth,
            day: defaultDay,
            hour: defaultHour,
            minute: defaultMinute,
            second: newSecond,
          ),
        ],
      );
    });
  });
}
