import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/api_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiRepository repository;

  HomeBloc({required Submission submission, required this.repository})
      : super(
          HomeState.fromSubmission(submission),
        ) {
    on<HomeTimestampChanged>(_onTimestampChanged);
    on<HomeScoreChanged>(_onScoreChanged);
    on<HomeSelectionsChanged>(_onSelectionsChanged);
    on<HomeSurveyRequested>(_onSurveyRequested);
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

  void _onSelectionsChanged(
    HomeSelectionsChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(selections: event.selections));
  }

  void _onSurveyRequested(
    HomeSurveyRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(surveyStatus: SurveyStatus.loading));
    try {
      Survey survey = await repository.fetchSurvey();
      emit(state.copyWith(survey: survey, surveyStatus: SurveyStatus.success));
    } catch (err) {
      emit(state.copyWith(surveyStatus: SurveyStatus.failure));
    }
  }
}
