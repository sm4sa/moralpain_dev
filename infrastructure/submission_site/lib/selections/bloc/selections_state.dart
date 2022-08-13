part of 'selections_bloc.dart';

class SelectionsState extends Equatable {
  final List<String> selections;

  const SelectionsState(this.selections);

  @override
  List<Object> get props => [selections];
}
