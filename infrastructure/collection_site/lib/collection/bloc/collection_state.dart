part of 'collection_bloc.dart';

abstract class CollectionState<T> extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

class CollectionInitial<T> extends CollectionState<T> {
  const CollectionInitial();
}

class CollectionInProgress<T> extends CollectionState<T> {
  const CollectionInProgress();
}

class CollectionSuccess<T> extends CollectionState<T> {
  final List<T> collection;

  const CollectionSuccess(this.collection);

  @override
  List<Object> get props => [collection];
}

class CollectionFailure<T> extends CollectionState<T> {
  const CollectionFailure();
}
