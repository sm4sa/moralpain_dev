import 'package:bloc/bloc.dart';

class ScoreCubit extends Cubit<int> {
  ScoreCubit([int initial = 0]) : super(initial);

  void set(int val) => emit(val);
}
