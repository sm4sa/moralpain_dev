import 'package:built_collection/built_collection.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:moralpainapi/moralpainapi.dart';

class SubmissionFetchFailure implements Exception {
  final String message;

  const SubmissionFetchFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  @override
  String toString() {
    return 'SurveyFectchFailure: $message';
  }
}

class SurveyFetchFailure implements Exception {
  final String message;

  const SurveyFetchFailure([this.message = 'An unknown exception occurred.']);

  @override
  String toString() {
    return 'SurveyFectchFailure: $message';
  }
}

class ApiRepository {
  final Logger log = Logger('SingleSubmissionRepository');
  final Moralpainapi mapi = Moralpainapi(
      basePathOverride:
          'https://umd7orqgt1.execute-api.us-east-1.amazonaws.com/v1');

  ApiRepository() {
    mapi.dio.options.connectTimeout = 30 * 1000;
    mapi.dio.options.receiveTimeout = 30 * 1000;
    mapi.dio.options.sendTimeout = 30 * 1000;
  }

  /// Fetches the submission with the given ID.
  Future<Submission> fetchSubmission(String id) async {
    // TODO: have this method call the API client instead of returning a dummy
    /*final AdminApi aapi = mapi.getAdminApi();

    try {
      final response = await aapi.getSubmissions(uuid: id);
      final Submissions submissions = response.data!;

      if (submissions.list == null) {
        throw const SubmissionFetchFailure(
          'List of submissions is null.',
        );
      } else if (submissions.list!.isEmpty) {
        throw SubmissionFetchFailure('No submission exists with UUID $id.');
      }

      return submissions.list!.first;
    } catch (err) {
      throw SubmissionFetchFailure(err.toString());
    }*/

    final builder = SubmissionBuilder();
    builder.id = '119ada26-a0ba-4991-82f4-d6aa7c73c503';
    builder.score = 4;
    builder.timestamp = 1658944322;
    builder.selections = ListBuilder(['001_02', '001_03', '002_02', '004_06']);
    return builder.build();
  }

  /// Submits the given submission to the database.
  ///
  /// Returns true if submission is successful and false otherwise.
  Future<bool> submitSubmission(Submission submission) async {
    /// TODO: have this method call the API client instead of returning a dummy
    return false;
  }

  /// Fetch the latest version of the moral distress survey from the API.
  /// Fall back to a local copy on error.
  Future<Survey> fetchSurvey() async {
    final uapi = mapi.getUserApi();

    try {
      return (await uapi.getSurvey()).data!;
    } catch (err) {
      log.warning('Error fetching survey. Falling back to local file.', err);
      return fetchSurveyAt('assets/local_survey.json');
    }
  }

  /// Fetch a locally stored version of the survey.
  Future<Survey> fetchSurveyAt(String path) async {
    try {
      final json = await rootBundle.loadString(path);
      return standardSerializers.fromJson(Survey.serializer, json)!;
    } catch (err) {
      log.shout('Error fetching local survey. Loading empty survey.', err);
    }

    return Survey();
  }
}
