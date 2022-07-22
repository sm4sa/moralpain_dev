part of 'collection_bloc.dart';

abstract class CollectionEvent<T> extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class CollectionStarted<T> extends CollectionEvent<T> {
  final Map<String, dynamic> params;

  const CollectionStarted(this.params);

  @override
  List<Object> get props => [params];
}
