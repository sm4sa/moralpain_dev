import 'package:collection_site/collection/bloc/collection_bloc.dart';
import 'package:collection_site/collection_api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CollectionRoute<T> extends StatelessWidget {
  final CollectionApiRepository<T> repository;

  final String initialMessage;
  final String emptyCollectionMessage;
  final String errorMessage;

  const CollectionRoute({
    Key? key,
    required this.repository,
    this.initialMessage = 'Collection hasn\'t started loading yet.',
    this.emptyCollectionMessage = 'No items in collection.',
    this.errorMessage = 'Error fetching collection.',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => CollectionBloc<T>(repository: repository)
          ..add(const CollectionStarted({})),
        child: CollectionView<T>(
          initialMessage: initialMessage,
          emptyCollectionMessage: emptyCollectionMessage,
          errorMessage: errorMessage,
          itemToWidget: display,
        ),
      ),
    );
  }

  Widget display(T item);
}

class CollectionView<T> extends StatelessWidget {
  final String initialMessage;
  final String emptyCollectionMessage;
  final String errorMessage;
  final Function itemToWidget;

  const CollectionView({
    Key? key,
    required this.initialMessage,
    required this.emptyCollectionMessage,
    required this.errorMessage,
    required this.itemToWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc<T>, CollectionState<T>>(
      builder: handleLoadEvents,
    );
  }

  Widget handleLoadEvents(BuildContext context, CollectionState<T> state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: contentFromState(state),
    );
  }

  Widget contentFromState(CollectionState<T> state) {
    if (state is CollectionInitial<T>) {
      return Center(child: Text(initialMessage));
    } else if (state is CollectionInProgress<T>) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CollectionSuccess<T>) {
      return Center(child: displayCollection(state.collection));
    } else if (state is CollectionFailure<T>) {
      return Center(child: Text(errorMessage));
    } else {
      assert(false);
      return ErrorWidget('Error State');
    }
  }

  Widget displayCollection(List<T> collection) {
    if (collection.isEmpty) {
      return Text(emptyCollectionMessage);
    } else {
      return SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final item in collection) itemToWidget(item),
          ],
        ),
      );
    }
  }
}
