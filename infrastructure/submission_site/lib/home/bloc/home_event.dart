part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeScoreSet extends HomeEvent {
  final int score;

  const HomeScoreSet(this.score);

  @override
  List<Object?> get props => [score];
}
