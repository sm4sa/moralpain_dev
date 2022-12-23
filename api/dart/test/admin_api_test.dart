import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';


/// tests for AdminApi
void main() {
  final instance = Moralpainapi().getAdminApi();

  group(AdminApi, () {
    // Get survey results
    //
    // Fetch from the database all of the records that match the query parameters. 
    //
    //Future<Submissions> getAdminSubmissions({ int starttime, int endtime, int minscore, int maxscore, String uuid }) async
    test('test getAdminSubmissions', () async {
      // TODO
    });

    // Get data analysis
    //
    // Perform an analysis on the records in the database that match the query paramters. 
    //
    //Future<AnalyticsResult> getAnalytics(String operation, { int starttime, int endtime }) async
    test('test getAnalytics', () async {
      // TODO
    });

  });
}
