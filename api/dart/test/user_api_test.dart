import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';


/// tests for UserApi
void main() {
  final instance = Moralpainapi().getUserApi();

  group(UserApi, () {
    // Get resiliency resources
    //
    // Fetch the recommended resiliency resources from the database. 
    //
    //Future<ResiliencyResources> getResiliencyResources() async
    test('test getResiliencyResources', () async {
      // TODO
    });

    // get the submissions
    //
    // Get the MDQ submissions using TypeDB. 
    //
    //Future<Submissions> getSubmissions() async
    test('test getSubmissions', () async {
      // TODO
    });

    // Get the MDQ
    //
    // Fetch the latest moral distress questionnaire (MDQ) from the database. 
    //
    //Future<Survey> getSurvey() async
    test('test getSurvey', () async {
      // TODO
    });

    // Submit a submission
    //
    // Submit with TypeDB 
    //
    //Future<String> submitSubmissionTypeDB({ Submission submission }) async
    test('test submitSubmissionTypeDB', () async {
      // TODO
    });

    // Submit a completed MDQ
    //
    // Submit a completed Moral Distress Questionnaire and Moral Distress Score to the database. 
    //
    //Future<String> submitSurvey({ Submission submission }) async
    test('test submitSurvey', () async {
      // TODO
    });

    // Submit visited resiliency resources
    //
    // Submit the list of resources visited by this user to the database. 
    //
    //Future<String> submitVisitedResiliencyResources({ VisitedResiliencyResources visitedResiliencyResources }) async
    test('test submitVisitedResiliencyResources', () async {
      // TODO
    });

  });
}
