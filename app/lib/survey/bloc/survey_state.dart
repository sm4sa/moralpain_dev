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

class SurveyComplete extends SurveyState {
  List<String> selections;
  int score;

  SurveyComplete(this.score, this.selections);
}

class SurveyUpdated extends SurveyState {
  Map<String, bool> selections;

  SurveyUpdated(this.selections);
}
