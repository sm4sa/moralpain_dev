import 'package:admin/screens/submissions/submissions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SubmissionsLoadEvent', () {
    final int? starttime = 1640995200;
    final int? endtime = 1647907200;
    final int? minscore = 0;
    final int? maxscore = 10;

    test('supports value equality', () {
      expect(
        SubmissionsLoadEvent(
          starttime: starttime,
          endtime: endtime,
          minscore: minscore,
          maxscore: maxscore,
        ),
        equals(SubmissionsLoadEvent(
          starttime: starttime,
          endtime: endtime,
          minscore: minscore,
          maxscore: maxscore,
        )),
      );
    });

    test('props are correct', () {
      expect(
        SubmissionsLoadEvent(
          starttime: starttime,
          endtime: endtime,
          minscore: minscore,
          maxscore: maxscore,
        ).props,
        equals([starttime, endtime, minscore, maxscore]),
      );
    });
  });
}
