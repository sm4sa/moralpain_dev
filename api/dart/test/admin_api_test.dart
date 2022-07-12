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
    //Future<Submissions> getSubmissions({ int starttime, int endtime, int minscore, int maxscore }) async
    test('test getSubmissions', () async {
      // TODO
    });

  });
}
