import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';


/// tests for CORSApi
void main() {
  final instance = Moralpainapi().getCORSApi();

  group(CORSApi, () {
    // CORS support
    //
    // Enable CORS by returning correct headers 
    //
    //Future surveyOptions() async
    test('test surveyOptions', () async {
      // TODO
    });

  });
}
