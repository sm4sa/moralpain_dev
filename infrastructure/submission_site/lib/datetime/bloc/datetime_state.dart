part of 'datetime_bloc.dart';

class DatetimeState extends Equatable {
  final int year;
  final Month month;
  final int day;
  final int hour;
  final int minute;
  final int second;

  const DatetimeState({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
  });

  @override
  List<Object?> get props => [year, month, day, hour, minute, second];

  DatetimeState copyWith({
    int? year,
    Month? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
  }) {
    return DatetimeState(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }

  static DatetimeState fromTimestamp(int timestamp) {
    final datetime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toUtc();
    return DatetimeState(
      year: datetime.year,
      month: Month.fromInt(datetime.month),
      day: datetime.day,
      hour: datetime.hour,
      minute: datetime.minute,
      second: datetime.second,
    );
  }
}
