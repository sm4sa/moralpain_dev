part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeTimestampChanged extends HomeEvent {
  final int timestamp;

  const HomeTimestampChanged(this.timestamp);

  @override
  List<Object> get props => [timestamp];
}

class HomeScoreChanged extends HomeEvent {
  final int score;

  const HomeScoreChanged(this.score);

  @override
  List<Object> get props => [score];
}

class HomeSelectionsChanged extends HomeEvent {
  final List<String> selections;

  const HomeSelectionsChanged(this.selections);

  @override
  List<Object> get props => [selections];
}

class HomeSurveyRequested extends HomeEvent {
  const HomeSurveyRequested();

  @override
  List<Object> get props => [];
}
