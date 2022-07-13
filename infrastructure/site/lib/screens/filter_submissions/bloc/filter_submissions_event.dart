part of 'filter_submissions_bloc.dart';

abstract class FilterSubmissionsEvent extends Equatable {
  const FilterSubmissionsEvent();

  @override
  List<Object?> get props => [];
}

class FilterSubmissionsStartTimeChanged extends FilterSubmissionsEvent {
  const FilterSubmissionsStartTimeChanged(this.starttime);

  final String? starttime;

  @override
  List<Object?> get props => [starttime];
}

class FilterSubmissionsEndTimeChanged extends FilterSubmissionsEvent {
  const FilterSubmissionsEndTimeChanged(this.endtime);

  final String? endtime;

  @override
  List<Object?> get props => [endtime];
}

class FilterSubmissionsMinScoreChanged extends FilterSubmissionsEvent {
  const FilterSubmissionsMinScoreChanged(this.minscore);

  final String? minscore;

  @override
  List<Object?> get props => [minscore];
}

class FilterSubmissionsMaxScoreChanged extends FilterSubmissionsEvent {
  const FilterSubmissionsMaxScoreChanged(this.maxscore);

  final String? maxscore;

  @override
  List<Object?> get props => [maxscore];
}
