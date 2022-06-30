import 'package:admin/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:uuid/uuid.dart';

part 'submissions_state.dart';
part 'submissions_event.dart';

class SubmissionsBloc extends Bloc<SubmissionsEvent, SubmissionsState> {
  final log = Logger('SubmissionsBloc');
  final uuid = Uuid();

  final ApiRepository repository;

  SubmissionsBloc({required this.repository}) : super(SubmissionsLoading()) {
    on<SubmissionsLoadEvent>(_onLoad);
  }

  void _onLoad(
    SubmissionsLoadEvent event,
    Emitter<SubmissionsState> emit,
  ) async {
    emit(SubmissionsLoading());

    final data = await repository.fetchSubmissions(
      starttime: event.starttime,
      endtime: event.endtime,
      minscore: event.minscore,
      maxscore: event.maxscore,
    );
    emit(SubmissionsLoaded(data));
  }
}
