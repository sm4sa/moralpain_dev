import 'package:analytics_site/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moralpainapi/moralpainapi.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final ApiRepository repository;

  AnalyticsBloc({required this.repository}) : super(const AnalyticsInitial()) {
    on<AnalyticsStarted>(_onLoad);
  }

  void _onLoad(AnalyticsStarted event, Emitter<AnalyticsState> emit) async {
    emit(const AnalyticsInProgress());

    AnalyticsResult data;
    try {
      data = await repository.fetchAnalytics(
        operation: event.operation,
        starttime: event.starttime,
        endtime: event.endtime,
      );
      emit(AnalyticsSuccess(data));
    } catch (_) {
      emit(AnalyticsFailure());
    }
  }
}
