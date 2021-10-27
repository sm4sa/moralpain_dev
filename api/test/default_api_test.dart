import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';


/// tests for DefaultApi
void main() {
  final instance = Moralpainapi().getDefaultApi();

  group(DefaultApi, () {
    // Fetch moral distress survey
    //
    //Future<Survey> getSurvey() async
    test('test getSurvey', () async {
      // TODO
    });

    // Submit completed moral distress survey
    //
    //Future<String> submitSurvey({ Submission submission }) async
    test('test submitSurvey', () async {
      // TODO
    });

  });
}
