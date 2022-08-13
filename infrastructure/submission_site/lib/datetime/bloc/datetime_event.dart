part of 'datetime_bloc.dart';

abstract class DatetimeEvent extends Equatable {
  const DatetimeEvent();
}

class DatetimeYearChanged extends DatetimeEvent {
  final int year;

  const DatetimeYearChanged(this.year);

  @override
  List<Object> get props => [year];
}

class DatetimeMonthChanged extends DatetimeEvent {
  final Month month;

  const DatetimeMonthChanged(this.month);

  @override
  List<Object> get props => [month];
}

class DatetimeDayChanged extends DatetimeEvent {
  final int day;

  const DatetimeDayChanged(this.day);

  @override
  List<Object> get props => [day];
}

class DatetimeHourChanged extends DatetimeEvent {
  final int hour;

  const DatetimeHourChanged(this.hour);

  @override
  List<Object> get props => [hour];
}

class DatetimeMinuteChanged extends DatetimeEvent {
  final int minute;

  const DatetimeMinuteChanged(this.minute);

  @override
  List<Object> get props => [minute];
}

class DatetimeSecondChanged extends DatetimeEvent {
  final int second;

  const DatetimeSecondChanged(this.second);

  @override
  List<Object> get props => [second];
}
