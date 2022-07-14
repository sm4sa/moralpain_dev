import 'dart:async' show Future;
import 'package:logging/logging.dart';
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

class AnalyticsFetchFailure implements Exception {
  const AnalyticsFetchFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  final String message;

  @override
  String toString() {
    return 'AnalyticsFetchFailure($message)';
  }
}

class SurveyFetchFailure implements Exception {
  const SurveyFetchFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  final String message;
}

class ApiRepository {
  final log = Logger('AdminRepository');

  late Moralpainapi mapi;

  ApiRepository(
      {String basePathOverride =
          'https://umd7orqgt1.execute-api.us-east-1.amazonaws.com/v1'}) {
    mapi = Moralpainapi(basePathOverride: basePathOverride);
    mapi.dio.options.connectTimeout = 30 * 1000;
    mapi.dio.options.receiveTimeout = 30 * 1000;
    mapi.dio.options.sendTimeout = 30 * 1000;
  }

  Future<Submissions> fetchSubmissions({
    int? starttime,
    int? endtime,
    int? minscore,
    int? maxscore,
  }) async {
    final aapi = mapi.getAdminApi();

    try {
      return (await aapi.getSubmissions(
        starttime: starttime,
        endtime: endtime,
        minscore: minscore,
        maxscore: maxscore,
      ))
          .data!;
    } catch (err) {
      throw SubmissionsFetchFailure(err.toString());
    }
  }

  Future<AnalyticsResult> fetchAnalytics({
    required String operation,
    int? starttime,
    int? endtime,
  }) async {
    final aapi = mapi.getAdminApi();

    try {
      var response = await aapi.getAnalytics(
        operation: operation,
        starttime: starttime,
        endtime: endtime,
      );
      return response.data!;
    } catch (err) {
      throw AnalyticsFetchFailure(err.toString());
    }
  }

  Future<Survey> fetchSurvey() async {
    final uapi = mapi.getUserApi();

    try {
      return (await uapi.getSurvey()).data!;
    } catch (err) {
      throw (SurveyFetchFailure(err.toString()));
    }
  }
}
