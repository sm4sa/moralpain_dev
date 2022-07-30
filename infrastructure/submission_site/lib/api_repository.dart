import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:moralpainapi/moralpainapi.dart';

class SurveyFetchFailure implements Exception {
  final String message;

  const SurveyFetchFailure({this.message = 'An unknown exception occurred.'});

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
