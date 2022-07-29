import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'datetime_event.dart';
part 'datetime_state.dart';

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december;

  @override
  String toString() {
    switch (this) {
      case Month.january:
        return 'January';
      case Month.february:
        return 'February';
      case Month.march:
        return 'March';
      case Month.april:
        return 'April';
      case Month.may:
        return 'May';
      case Month.june:
        return 'June';
      case Month.july:
        return 'July';
      case Month.august:
        return 'August';
      case Month.september:
        return 'September';
      case Month.october:
        return 'October';
      case Month.november:
        return 'November';
      case Month.december:
        return 'December';
    }
  }

  int toInt() {
    return Month.values.indexOf(this) + 1;
  }

  int numberOfDays(int year) {
    switch (this) {
      case Month.january:
      case Month.march:
      case Month.may:
      case Month.july:
      case Month.august:
      case Month.october:
      case Month.december:
        return 31;
      case Month.february:
        if (year % 4 != 0) {
          // if year not divisible by 4
          return 28;
        }
        // if year is divisible by 4
        if (year % 100 != 0) {
          // if year not divisible by 100
          return 29;
        }
        // if year is divisible by 100
        if (year % 400 != 0) {
          // if year not divisible by 400
          return 28;
        }
        // if year is divisible by 400
        return 29;
      default:
        return 30;
    }
  }

  static Month fromInt(int i) {
    assert(i >= 1 && i <= 12);
    final monthsAsInts = Month.values.map((e) => e.toInt()).toList();
    int index = monthsAsInts.indexOf(i);
    return Month.values[index];
  }
}

class DatetimeBloc extends Bloc<DatetimeEvent, DatetimeState> {
  DatetimeBloc(int timestamp) : super(DatetimeState.fromTimestamp(timestamp)) {
    on<DatetimeYearChanged>(_onYearChanged);
    on<DatetimeMonthChanged>(_onMonthChanged);
    on<DatetimeDayChanged>(_onDayChanged);
    on<DatetimeHourChanged>(_onHourChanged);
    on<DatetimeMinuteChanged>(_onMinuteChanged);
    on<DatetimeSecondChanged>(_onSecondChanged);
  }

  void _onYearChanged(DatetimeYearChanged event, Emitter<DatetimeState> emit) {
    emit(state.copyWith(year: event.year));

    /*
    If current day is too big for the current month and new year
    (a.k.a. if current day and month is February 29 and new year is not a 
    leap year)
    change the day to the highest possible value.
    */
    int numDays = state.month.numberOfDays(event.year);
    if (state.day > numDays) {
      emit(state.copyWith(day: numDays));
    }
  }

  void _onMonthChanged(
      DatetimeMonthChanged event, Emitter<DatetimeState> emit) {
    emit(state.copyWith(month: event.month));

    /*
    If current day is too big for the new month,
    change the day to the highest possible value.
    */
    int numDays = event.month.numberOfDays(state.year);
    if (state.day > numDays) {
      emit(state.copyWith(day: numDays));
    }
  }

  void _onDayChanged(DatetimeDayChanged event, Emitter<DatetimeState> emit) {
    emit(state.copyWith(day: event.day));
  }

  void _onHourChanged(DatetimeHourChanged event, Emitter<DatetimeState> emit) {
    emit(state.copyWith(hour: event.hour));
  }

  void _onMinuteChanged(
      DatetimeMinuteChanged event, Emitter<DatetimeState> emit) {
    emit(state.copyWith(minute: event.minute));
  }

  void _onSecondChanged(
      DatetimeSecondChanged event, Emitter<DatetimeState> emit) {
    emit(state.copyWith(second: event.second));
  }
}
