import 'package:submissions_site/api_repository.dart';
import 'package:submissions_site/submissions/submissions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moralpainapi/moralpainapi.dart';

void main() {
  group('SubmissionsRoute', () {
    group('display', () {
      test('returns a SubmissionListTile of the given Submission', () {
        final submission = Submission();
        final submissionsRoute = SubmissionsRoute(repository: ApiRepository());
        final submissionDisplay = submissionsRoute.display(submission);
        expect(submissionDisplay, isA<SubmissionListTile>());
        expect(
          (submissionDisplay as SubmissionListTile).submission,
          equals(submission),
        );
      });
    });
  });
}
