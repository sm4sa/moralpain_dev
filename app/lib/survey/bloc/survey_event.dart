part of 'survey_bloc.dart';

abstract class SurveyEvent {
  const SurveyEvent();
}

class SurveyLoadEvent extends SurveyEvent {
  const SurveyLoadEvent();
}

class SurveyUpdateEvent extends SurveyEvent {
  final String surveyId;
  const SurveyUpdateEvent(this.surveyId);
}

class SurveySubmitEvent extends SurveyEvent {
  const SurveySubmitEvent();
}
