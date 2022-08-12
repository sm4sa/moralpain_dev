import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';


/// tests for SubmissionApi
void main() {
  final instance = Moralpainapi().getSubmissionApi();

  group(SubmissionApi, () {
    // get the submission
    //
    // Get the MDQ submission. 
    //
    //Future<Submission> getSubmission() async
    test('test getSubmission', () async {
      // TODO
    });

  });
}
