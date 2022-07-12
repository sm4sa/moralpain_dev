part of 'analytics_bloc.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object?> get props => [];
}

class AnalyticsStarted extends AnalyticsEvent {
  const AnalyticsStarted(
      {required this.operation, this.starttime, this.endtime});

  final String operation;
  final int? starttime;
  final int? endtime;

  @override
  List<Object?> get props => [operation, starttime, endtime];
}
