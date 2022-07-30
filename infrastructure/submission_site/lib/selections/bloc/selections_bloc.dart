import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selections_event.dart';
part 'selections_state.dart';

class SelectionsBloc extends Bloc<SelectionsEvent, SelectionsState> {
  SelectionsBloc(List<String> selections) : super(SelectionsState(selections)) {
    on<SelectionsSelectionAdded>(_onSelectionAdded);
    on<SelectionsSelectionRemoved>(_onSelectionRemoved);
  }

  void _onSelectionAdded(
    SelectionsSelectionAdded event,
    Emitter<SelectionsState> emit,
  ) async {
    if (!state.selections.contains(event.selection)) {
      final newSelections = List<String>.from(state.selections);
      newSelections.add(event.selection);
      emit(SelectionsState(newSelections));
    }
  }

  void _onSelectionRemoved(
    SelectionsSelectionRemoved event,
    Emitter<SelectionsState> emit,
  ) async {
    if (state.selections.contains(event.selection)) {
      final newSelections = List<String>.from(state.selections);
      newSelections.remove(event.selection);
      emit(SelectionsState(newSelections));
    }
  }
}
