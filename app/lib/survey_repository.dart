import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:moralpain/assets/constants.dart' as Constants;
import 'package:moralpainapi/moralpainapi.dart';
import 'package:moralpainapi/src/model/survey.dart';

class SurveyRepository {
  final mapi = Moralpainapi(
      basePathOverride:
          'https://umd7orqgt1.execute-api.us-east-1.amazonaws.com/v1');

  Future<Survey> fetchSurvey() async {
    final dapi = mapi.getDefaultApi();
    mapi.dio.options.headers["Access-Control_Allow_Origin"] = "*";

    try {
      return (await dapi.getSurvey()).data!;
    } catch (err) {
      print('Error fetching survey: $err');
      print('Falling back to local survey.');
    }

    return fetchSurveyAt(Constants.SURVEY_QUESTIONNAIRE_PATH);
  }

  Future<Survey> fetchSurveyAt(String path) async {
    var json = await rootBundle.loadString(path);

    return standardSerializers.fromJson(Survey.serializer, json)!;
  }
}
