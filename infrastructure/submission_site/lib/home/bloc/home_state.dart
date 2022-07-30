part of 'home_bloc.dart';

enum SurveyStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final String id;
  final int score;
  final int timestamp;
  final List<String> selections;
  final Survey? survey;
  final SurveyStatus surveyStatus;

  const HomeState({
    required this.id,
    required this.score,
    required this.timestamp,
    required this.selections,
    this.survey,
    this.surveyStatus = SurveyStatus.initial,
  });

  @override
  List<Object?> get props =>
      [id, score, timestamp, selections, survey, surveyStatus];

  HomeState copyWith({
    String? id,
    int? score,
    int? timestamp,
    List<String>? selections,
    Survey? survey,
    SurveyStatus? surveyStatus,
  }) {
    return HomeState(
        id: id ?? this.id,
        score: score ?? this.score,
        timestamp: timestamp ?? this.timestamp,
        selections: selections ?? this.selections,
        survey: survey ?? this.survey,
        surveyStatus: surveyStatus ?? this.surveyStatus);
  }

  static HomeState fromSubmission(Submission submission) {
    assert(
      submission.id != null &&
          submission.score != null &&
          submission.timestamp != null &&
          submission.selections != null,
    );
    return HomeState(
      id: submission.id!,
      score: submission.score!,
      timestamp: submission.timestamp!,
      selections: submission.selections!.toList(),
    );
  }
}
