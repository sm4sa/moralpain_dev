import 'package:bloc/bloc.dart';
import 'package:collection_site/collection_api_repository.dart';
import 'package:equatable/equatable.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc<T> extends Bloc<CollectionEvent<T>, CollectionState<T>> {
  final CollectionApiRepository<T> repository;

  CollectionBloc({required this.repository})
      : super(const CollectionInitial()) {
    on<CollectionStarted<T>>(_onLoad);
  }

  void _onLoad(
    CollectionStarted<T> event,
    Emitter<CollectionState<T>> emit,
  ) async {
    emit(const CollectionInProgress());

    List<T> data;
    try {
      data = await repository.fetchCollection(event.params);
      emit(CollectionSuccess(data));
    } catch (_) {
      emit(const CollectionFailure());
    }
  }
}
