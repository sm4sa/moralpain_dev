part of 'questionnaire_bloc.dart';

abstract class QuestionnaireEvent {
  const QuestionnaireEvent();
}

class QuestionnaireLoadEvent extends QuestionnaireEvent {
  // needs a questionnaire
  const QuestionnaireLoadEvent();
}

class QuestionnaireUpdateEvent extends QuestionnaireEvent {
  final String questionId;
  const QuestionnaireUpdateEvent(this.questionId);
}

class QuestionnaireSubmitEvent extends QuestionnaireEvent {
  const QuestionnaireSubmitEvent();
}
