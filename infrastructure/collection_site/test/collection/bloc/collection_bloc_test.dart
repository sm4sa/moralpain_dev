import 'package:bloc_test/bloc_test.dart';
import 'package:collection_site/collection_site.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCollectionApiRepository<T> extends Mock
    implements CollectionApiRepository<T> {}

void main() {
  const mockCollection = [1, 2, 3];

  group('CollectionBloc', () {
    late CollectionApiRepository<int> repository;

    setUp(() {
      repository = MockCollectionApiRepository();
      when(
        () => repository.fetchCollection(any()),
      ).thenAnswer((_) => Future.value(mockCollection));
    });

    CollectionBloc buildBloc() => CollectionBloc<int>(repository: repository);

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(buildBloc().state, equals(const CollectionInitial<int>()));
      });
    });

    group('CollectionStarted', () {
      const Map<String, dynamic> params = {'name': 'value'};

      CollectionEvent buildEvent() => const CollectionStarted<int>(params);

      blocTest<CollectionBloc, CollectionState>(
        'fetches collection from repository',
        build: buildBloc,
        act: (bloc) => bloc.add(buildEvent()),
        verify: (_) {
          verify(() => repository.fetchCollection(params)).called(1);
        },
      );

      blocTest<CollectionBloc, CollectionState>(
        'emits success state with collection '
        'when fetchCollection completes properly',
        build: buildBloc,
        act: (bloc) => bloc.add(buildEvent()),
        expect: () => [
          const CollectionInProgress<int>(),
          const CollectionSuccess<int>(mockCollection),
        ],
      );

      blocTest<CollectionBloc, CollectionState>(
        'emits failure state when fetchCollection fails',
        setUp: () {
          when(
            () => repository.fetchCollection(any()),
          ).thenThrow(Exception('oops'));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(buildEvent()),
        expect: () => [
          const CollectionInProgress<int>(),
          const CollectionFailure<int>(),
        ],
      );
    });
  });
}
