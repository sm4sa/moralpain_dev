part of 'submissions_bloc.dart';

abstract class SubmissionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmissionsInitial extends SubmissionsState {}

class SubmissionsLoading extends SubmissionsState {}

class SubmissionsLoaded extends SubmissionsState {
  final Submissions submissions;

  SubmissionsLoaded(this.submissions);

  @override
  List<Object?> get props => [submissions];
}

class SubmissionsLoadFailed extends SubmissionsState {}
