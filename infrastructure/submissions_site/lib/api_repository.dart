import 'dart:async' show Future;
import 'package:collection_site/collection_site.dart';
import 'package:moralpainapi/moralpainapi.dart';

class SubmissionsFetchFailure implements Exception {
  const SubmissionsFetchFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  final String message;

  @override
  String toString() {
    return 'SubmissionsFetchFailure($message)';
  }
}

class ApiRepository extends CollectionApiRepository<Submission> {
  ApiRepository({String? basePathOverride})
      : super(paramDefs: {
          'starttime': int,
          'endtime': int,
          'minscore': int,
          'maxscore': int,
        }, basePathOverride: basePathOverride);

  @override
  Future<List<Submission>> fetchCollection(Map<String, dynamic> params) async {
    // Verify that the parameters are valid
    validateParams(params);

    // Call getSubmissions() with the given parameters
    final aapi = mapi.getAdminApi();

    try {
      Submissions submissions = (await aapi.getSubmissions(
        starttime: params['starttime'],
        endtime: params['endtime'],
        minscore: params['minscore'],
        maxscore: params['maxscore'],
      ))
          .data!;
      if (submissions.list != null) return submissions.list!.toList();
      return [];
    } catch (err) {
      throw CollectionFetchFailure<Submission>(err.toString());
    }
  }
}
