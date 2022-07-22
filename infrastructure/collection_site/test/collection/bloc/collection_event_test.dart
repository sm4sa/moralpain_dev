import 'package:collection_site/collection/bloc/collection_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CollectionStarted', () {
    const Map<String, dynamic> params = {};

    test('supports value equality', () {
      expect(
        const CollectionStarted(params),
        equals(const CollectionStarted(params)),
      );
    });

    test('props are correct', () {
      expect((const CollectionStarted(params)).props, equals([params]));
    });
  });
}
