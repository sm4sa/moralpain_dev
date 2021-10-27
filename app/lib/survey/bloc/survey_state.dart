part of 'survey_bloc.dart';

abstract class SurveyState {
  final Set<String> optionsSelected;

  SurveyState() : optionsSelected = Set();
}

class SurveyLoading extends SurveyState {}

class SurveyLoaded extends SurveyState {
  final Survey survey;

  SurveyLoaded(this.survey);
}

class SurveyComplete extends SurveyState {}
