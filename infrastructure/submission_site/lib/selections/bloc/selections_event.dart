part of 'selections_bloc.dart';

abstract class SelectionsEvent extends Equatable {
  const SelectionsEvent();
}

class SelectionsSelectionAdded extends SelectionsEvent {
  final String selection;

  const SelectionsSelectionAdded(this.selection);

  @override
  List<Object> get props => [selection];
}

class SelectionsSelectionRemoved extends SelectionsEvent {
  final String selection;

  const SelectionsSelectionRemoved(this.selection);

  @override
  List<Object> get props => [selection];
}
