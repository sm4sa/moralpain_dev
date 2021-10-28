import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpain/survey_repository.dart';
import 'package:moralpainapi/src/model/survey.dart';

part 'survey_state.dart';
part 'survey_event.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final SurveyRepository repository;
  final options = Map<String, bool>();

  SurveyBloc({required this.repository}) : super(SurveyLoading()) {
    on<SurveyLoadEvent>(_onLoad);
    on<SurveySubmitEvent>(_onSubmit);
    on<SurveyUpdateEvent>(_onUpdate);
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
    final selected =
        options.entries.where((x) => x.value).map((x) => x.key).toList();
    emit(SurveyComplete(0, selected));
  }

  void _onUpdate(SurveyUpdateEvent event, Emitter<SurveyState> emit) {
    options[event.optionId] = event.value;

    emit(SurveyUpdated(options));
  }
}
