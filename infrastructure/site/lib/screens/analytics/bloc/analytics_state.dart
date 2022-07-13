part of 'analytics_bloc.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object> get props => [];
}

class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial();
}

class AnalyticsInProgress extends AnalyticsState {
  const AnalyticsInProgress();
}

class AnalyticsSuccess extends AnalyticsState {
  const AnalyticsSuccess(this.result);

  final AnalyticsResult result;

  @override
  List<Object> get props => [result];
}

class AnalyticsFailure extends AnalyticsState {
  const AnalyticsFailure();
}
