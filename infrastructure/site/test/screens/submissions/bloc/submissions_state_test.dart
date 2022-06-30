import 'package:admin/screens/submissions/submissions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moralpainapi/moralpainapi.dart';

void main() {
  group('SubmissionsLoading', () {
    test('supports equality', () {
      expect(
        SubmissionsLoading(),
        equals(SubmissionsLoading()),
      );
    });

    test('props are correct', () {
      expect(
        SubmissionsLoading().props,
        equals(<Object>[]),
      );
    });
  });

  group('SubmissionsLoaded', () {
    late Submissions submissions;

    setUp(() {
      submissions = Submissions();
    });

    test('supports equality', () {
      expect(
        SubmissionsLoaded(submissions),
        equals(SubmissionsLoaded(submissions)),
      );
    });

    test('props are correct', () {
      expect(
        SubmissionsLoaded(submissions).props,
        equals(<Object>[submissions]),
      );
    });
  });
}
