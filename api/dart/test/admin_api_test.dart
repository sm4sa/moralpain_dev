import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';

import './constants.dart';

/// tests for AdminApi
void main() {
  final mapi = Moralpainapi(basePathOverride: MOCK_API_URL);
  final instance = mapi.getAdminApi();

  group(AdminApi, () {
    // Get data analysis
    //
    // Perform an analysis on the records in the database that match the query paramters.
    //
    //Future<Submissions> getAnalytics(String operation, { int starttime, int endtime }) async
    test('test getAnalytics', () async {
      // TODO
    });

    // Get survey results
    //
    // Fetch from the database all of the records that match the query parameters.
    //
    //Future<Submissions> getSubmissions({ int starttime, int endtime, int minscore, int maxscore }) async
    group('getSubmissions', () {
      String placeholderJson = '{'
          '"list":[{'
          '"score": 0,'
          '"selections": ["string"],'
          '"timestamp": 0,'
          '"id": "string"'
          '}]'
          '}';

      Submissions placeholderSubmissions = standardSerializers.fromJson(
        Submissions.serializer,
        placeholderJson,
      )!;

      test('returns correct Submissions object', () async {
        expect(
          (await instance.getSubmissions()).data,
          equals(placeholderSubmissions),
        );
      });
    });
  });
}
