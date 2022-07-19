import 'package:submissions_site/filter_submissions/filter_submissions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FilterSubmissionsStartTimeChanged', () {
    const starttime = '5963';

    test('supports value equality', () {
      expect(
        FilterSubmissionsStartTimeChanged(starttime),
        equals(FilterSubmissionsStartTimeChanged(starttime)),
      );
    });

    test('props are correct', () {
      expect(
        FilterSubmissionsStartTimeChanged(starttime).props,
        equals([starttime]),
      );
    });
  });

  group('FilterSubmissionsEndTimeChanged', () {
    const endtime = '41262816';

    test('supports value equality', () {
      expect(
        FilterSubmissionsEndTimeChanged(endtime),
        equals(FilterSubmissionsEndTimeChanged(endtime)),
      );
    });

    test('props are correct', () {
      expect(
        FilterSubmissionsEndTimeChanged(endtime).props,
        equals([endtime]),
      );
    });
  });

  group('FilterSubmissionsMinScoreChanged', () {
    const minscore = '3';

    test('supports value equality', () {
      expect(
        FilterSubmissionsMinScoreChanged(minscore),
        equals(FilterSubmissionsMinScoreChanged(minscore)),
      );
    });

    test('props are correct', () {
      expect(
        FilterSubmissionsMinScoreChanged(minscore).props,
        equals([minscore]),
      );
    });
  });

  group('FilterSubmissionsMaxScoreChanged', () {
    const maxscore = '7';

    test('supports value equality', () {
      expect(
        FilterSubmissionsMaxScoreChanged(maxscore),
        equals(FilterSubmissionsMaxScoreChanged(maxscore)),
      );
    });

    test('props are correct', () {
      expect(
        FilterSubmissionsMaxScoreChanged(maxscore).props,
        equals([maxscore]),
      );
    });
  });
}
