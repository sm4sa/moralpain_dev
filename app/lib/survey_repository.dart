import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:moralpain/assets/constants.dart' as Constants;
import 'package:moralpainapi/moralpainapi.dart';
import 'package:moralpainapi/src/model/survey.dart';

class SurveyRepository {
  Future<Survey> fetchDefaultSurvey() async =>
      fetchSurvey(Constants.SURVEY_QUESTIONNAIRE_PATH);

  Future<Survey> fetchSurvey(String path) async {
    var json = await rootBundle.loadString(path);

    return standardSerializers.fromJson(Survey.serializer, json)!;
  }

  Future<Survey> test(String path) async {
    var json = await rootBundle.loadString(path);

    return standardSerializers.fromJson(Survey.serializer, json)!;
  }
}
