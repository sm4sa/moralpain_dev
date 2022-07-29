part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String id;
  final int score;
  final int timestamp;
  final List<String> selections;

  const HomeState({
    required this.id,
    required this.score,
    required this.timestamp,
    required this.selections,
  });

  @override
  List<Object> get props => [id, score, timestamp, selections];

  HomeState copyWith({
    String? id,
    int? score,
    int? timestamp,
    List<String>? selections,
  }) {
    return HomeState(
      id: id ?? this.id,
      score: score ?? this.score,
      timestamp: timestamp ?? this.timestamp,
      selections: selections ?? this.selections,
    );
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
