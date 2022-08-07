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
  });
}
