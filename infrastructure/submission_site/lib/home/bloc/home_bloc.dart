import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:moralpainapi/moralpainapi.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(Submission submission)
      : super(
          HomeState.fromSubmission(submission),
        ) {
    on<HomeTimestampChanged>(_onTimestampChanged);
    on<HomeScoreChanged>(_onScoreChanged);
  }

  void _onTimestampChanged(
    HomeTimestampChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(timestamp: event.timestamp));
  }

  void _onScoreChanged(HomeScoreChanged event, Emitter<HomeState> emit) async {
    emit(state.copyWith(score: event.score));
  }
}
