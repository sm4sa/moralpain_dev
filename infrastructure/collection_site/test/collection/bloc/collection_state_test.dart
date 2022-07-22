import 'package:collection_site/collection_site.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CollectionInitial', () {
    test('supports equality', () {
      expect(const CollectionInitial(), equals(const CollectionInitial()));
    });

    test('props are correct', () {
      expect((const CollectionInitial()).props, equals([]));
    });
  });

  group('CollectionInProgress', () {
    test('supports equality', () {
      expect(
          const CollectionInProgress(), equals(const CollectionInProgress()));
    });

    test('props are correct', () {
      expect((const CollectionInProgress()).props, equals([]));
    });
  });

  group('CollectionSuccess', () {
    const collection = [1, 2, 3];

    test('supports equality', () {
      expect(
        const CollectionSuccess(collection),
        equals(const CollectionSuccess(collection)),
      );
    });

    test('props are correct', () {
      expect((const CollectionSuccess(collection)).props, equals([collection]));
    });
  });

  group('CollectionFailure', () {
    test('supports equality', () {
      expect(const CollectionFailure(), equals(const CollectionFailure()));
    });

    test('props are correct', () {
      expect((const CollectionFailure()).props, equals([]));
    });
  });
}
