import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_submissions_event.dart';
part 'filter_submissions_state.dart';

class FilterSubmissionsBloc
    extends Bloc<FilterSubmissionsEvent, FilterSubmissionsState> {
  FilterSubmissionsBloc() : super(const FilterSubmissionsState()) {
    on<FilterSubmissionsStartTimeChanged>(_onStartTimeChanged);
    on<FilterSubmissionsEndTimeChanged>(_onEndTimeChanged);
    on<FilterSubmissionsMinScoreChanged>(_onMinScoreChanged);
    on<FilterSubmissionsMaxScoreChanged>(_onMaxScoreChanged);
  }

  void _onStartTimeChanged(
    FilterSubmissionsStartTimeChanged event,
    Emitter<FilterSubmissionsState> emit,
  ) {
    emit(state.copyWith(starttime: event.starttime));
  }

  void _onEndTimeChanged(
    FilterSubmissionsEndTimeChanged event,
    Emitter<FilterSubmissionsState> emit,
  ) {
    emit(state.copyWith(endtime: event.endtime));
  }

  void _onMinScoreChanged(
    FilterSubmissionsMinScoreChanged event,
    Emitter<FilterSubmissionsState> emit,
  ) {
    emit(state.copyWith(minscore: event.minscore));
  }

  void _onMaxScoreChanged(
    FilterSubmissionsMaxScoreChanged event,
    Emitter<FilterSubmissionsState> emit,
  ) {
    emit(state.copyWith(maxscore: event.maxscore));
  }
}
