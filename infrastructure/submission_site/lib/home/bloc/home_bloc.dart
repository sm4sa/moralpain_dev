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
    on<HomeScoreSet>(_onScoreSet);
  }

  void _onScoreSet(HomeScoreSet event, Emitter<HomeState> emit) async {
    emit(state.copyWith(score: event.score));
  }
}
