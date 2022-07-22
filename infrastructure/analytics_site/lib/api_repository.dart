import 'dart:async' show Future;
import 'package:moralpainapi/moralpainapi.dart';

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

class ApiRepository {
  late Moralpainapi mapi;

  ApiRepository(
      {String basePathOverride =
          'https://umd7orqgt1.execute-api.us-east-1.amazonaws.com/v1'}) {
    mapi = Moralpainapi(basePathOverride: basePathOverride);
    mapi.dio.options.connectTimeout = 30 * 1000;
    mapi.dio.options.receiveTimeout = 30 * 1000;
    mapi.dio.options.sendTimeout = 30 * 1000;
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
}
