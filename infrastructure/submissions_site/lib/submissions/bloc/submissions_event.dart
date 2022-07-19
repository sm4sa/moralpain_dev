part of 'submissions_bloc.dart';

abstract class SubmissionsEvent extends Equatable {
  const SubmissionsEvent();

  @override
  List<Object?> get props => [];
}

class SubmissionsLoadEvent extends SubmissionsEvent {
  final int? starttime;
  final int? endtime;
  final int? minscore;
  final int? maxscore;

  const SubmissionsLoadEvent({
    this.starttime,
    this.endtime,
    this.minscore,
    this.maxscore,
  });

  @override
  List<Object?> get props => [starttime, endtime, minscore, maxscore];
}
