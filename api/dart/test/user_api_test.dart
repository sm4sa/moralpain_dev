import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';

import './constants.dart';

/// tests for UserApi
void main() {
  final instance = Moralpainapi(basePathOverride: MOCK_API_URL).getUserApi();

  group(UserApi, () {
    // Get resiliency resources
    //
    // Fetch the recommended resiliency resources from the database.
    //
    //Future<ResiliencyResources> getResiliencyResources() async
    group('getResiliencyResources', () {
      String placeholderJson = '{'
          '"version": "string",'
          '"resources": ['
          '{'
          '"resourceId": "string",'
          '"title": "string",'
          '"description": "string",'
          '"url": "string",'
          '"icon": {'
          '"codePoint": "string",'
          '"fontFamily": "string",'
          '"fontPackage": "string"'
          '}'
          '}'
          ']'
          '}';

      ResiliencyResources placeholderResiliency = standardSerializers.fromJson(
        ResiliencyResources.serializer,
        placeholderJson,
      )!;

      test('returns correct ResiliencyResources object', () async {
        expect(
          await (await instance.getResiliencyResources()).data,
          equals(placeholderResiliency),
        );
      });
    });

    // Get the MDQ
    //
    // Fetch the latest moral distress questionnaire (MDQ) from the database.
    //
    //Future<Survey> getSurvey() async
    group('getSurvey', () {
      String placeholderJson = '{'
          '"version": "string",'
          '"sections": ['
          '{'
          '"sectionId": "string",'
          '"title": "string",'
          '"subtitle": "string",'
          '"options": ['
          '{'
          '"id": "string",'
          '"description": "string"'
          '}'
          ']'
          '}'
          ']'
          '}';

      Survey placeholderSurvey = standardSerializers.fromJson(
        Survey.serializer,
        placeholderJson,
      )!;

      test('return correct Survey object', () async {
        expect(
          await (await instance.getSurvey()).data,
          equals(placeholderSurvey),
        );
      });
    });

    // Submit a completed MDQ
    //
    // Submit a completed Moral Distress Questionnaire and Moral Distress Score to the database.
    //
    //Future<String> submitSurvey({ Submission submission }) async
    group('submitSurvey', () {
      String placeholderJson = '{'
          '"score": 0,'
          '"selections": ['
          '"string"'
          '],'
          '"timestamp": 0,'
          '"id": "string"'
          '}';

      Submission placeholderSubmission = standardSerializers.fromJson(
        Submission.serializer,
        placeholderJson,
      )!;

      test('is successful when Submission is passed in', () async {
        Response<String> response = await instance.submitSurvey(
          submission: placeholderSubmission,
        );
        expect(response.statusCode, equals(200));
      });
    });

    // Submit visited resiliency resources
    //
    // Submit the list of resources visited by this user to the database.
    //
    //Future<String> submitVisitedResiliencyResources({ VisitedResiliencyResources visitedResiliencyResources }) async
    group('submitVisitedResiliencyResources', () {
      String placeholderJson = '{'
          'selections: ["string"],'
          'timestamp: 0'
          '}';

      VisitedResiliencyResources placeholderResources =
          standardSerializers.fromJson(
        VisitedResiliencyResources.serializer,
        placeholderJson,
      );

      test(
        'is successful when VisitedResiliencyResources is passed in',
        () async {
          Response<String> response =
              await instance.submitVisitedResiliencyResources(
            visitedResiliencyResources: placeholderResources,
          );
          expect(response.statusCode, equals(200));
        },
      );
    });
  });
}
