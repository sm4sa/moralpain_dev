part of 'filter_submissions_bloc.dart';

class FilterSubmissionsState extends Equatable {
  const FilterSubmissionsState({
    this.starttime,
    this.endtime,
    this.minscore,
    this.maxscore,
  });

  final String? starttime;
  final String? endtime;
  final String? minscore;
  final String? maxscore;

  FilterSubmissionsState copyWith({
    String? starttime,
    String? endtime,
    String? minscore,
    String? maxscore,
  }) {
    return FilterSubmissionsState(
      starttime: starttime ?? this.starttime,
      endtime: endtime ?? this.endtime,
      minscore: minscore ?? this.minscore,
      maxscore: maxscore ?? this.maxscore,
    );
  }

  @override
  List<Object?> get props => [starttime, endtime, minscore, maxscore];
}
