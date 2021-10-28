import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpain/survey_repository.dart';
import 'package:moralpainapi/src/model/survey.dart';

part 'survey_state.dart';
part 'survey_event.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final SurveyRepository repository;

  SurveyBloc({required this.repository}) : super(SurveyLoading()) {
    on<SurveyLoadEvent>(_onLoad);
    on<SurveySubmitEvent>(_onSubmit);
  }

  void _onLoad(SurveyLoadEvent event, Emitter<SurveyState> emit) async {
    emit(SurveyLoading());
    try {
      final data = await repository.fetchSurvey();
      emit(SurveyLoaded(data));
    } catch (error) {
      // Fail hard if we can't load the survey.
      assert(false);
    }
  }

  void _onSubmit(SurveySubmitEvent event, Emitter<SurveyState> emit) {
    emit(SurveyComplete());
  }
}
