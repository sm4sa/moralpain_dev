import 'package:admin/screens/filter_submissions/filter_submissions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FilterSubmissionsState', () {
    const String starttime = '1110000';
    const String endtime = '11111111';
    const String minscore = '2';
    const String maxscore = '8';

    test('supports value equality', () {
      expect(
        FilterSubmissionsState(
          starttime: starttime,
          endtime: endtime,
          minscore: minscore,
          maxscore: maxscore,
        ),
        equals(FilterSubmissionsState(
          starttime: starttime,
          endtime: endtime,
          minscore: minscore,
          maxscore: maxscore,
        )),
      );
    });

    test('props are correct', () {
      expect(
        FilterSubmissionsState(
          starttime: starttime,
          endtime: endtime,
          minscore: minscore,
          maxscore: maxscore,
        ).props,
        equals([starttime, endtime, minscore, maxscore]),
      );
    });

    group('copyWith', () {
      test('changes nothing when no parameters are passed', () {
        expect(
          FilterSubmissionsState().copyWith(),
          equals(FilterSubmissionsState()),
        );
      });

      test('changes nothing when parameters are null', () {
        expect(
          FilterSubmissionsState().copyWith(
            starttime: null,
            endtime: null,
            minscore: null,
            maxscore: null,
          ),
          equals(FilterSubmissionsState()),
        );
      });

      test('changes all field when all parameters are non-null', () {
        expect(
          FilterSubmissionsState().copyWith(
            starttime: starttime,
            endtime: endtime,
            minscore: minscore,
            maxscore: maxscore,
          ),
          equals(FilterSubmissionsState(
            starttime: starttime,
            endtime: endtime,
            minscore: minscore,
            maxscore: maxscore,
          )),
        );
      });
    });
  });
}
