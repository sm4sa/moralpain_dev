import 'package:collection_site/collection_site.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCollectionApiRepository<T> extends CollectionApiRepository<T> {
  MockCollectionApiRepository({required Map<String, Type> paramDefs})
      : super(paramDefs: paramDefs);

  @override
  Future<List<T>> fetchCollection(Map<String, dynamic> params) async => [];
}

void main() {
  group('CollectionFetchFailure', () {
    group('constructor', () {
      test(
        'creates exception with correct default message '
        'if no parameter is passed',
        () {
          expect(
            (const CollectionFetchFailure()).message,
            equals('An unknown exception occurred.'),
          );
        },
      );

      test('creates exception with message passed in as parameter', () {
        expect(
          (const CollectionFetchFailure('custom message')).message,
          equals('custom message'),
        );
      });
    });

    test('toString() works correctly', () {
      expect(
        (const CollectionFetchFailure<Object>('custom message')).toString(),
        equals('CollectionFetchFailure<Object>{message: custom message}'),
      );
    });
  });

  group('CollectionParamsInvalidException', () {
    const paramName = 'name';
    const expectedType = String;
    const actualType = bool;
    const exception = CollectionParamsInvalidException(
        paramName: paramName,
        expectedType: expectedType,
        actualType: actualType);

    test('constructor creates exception with correct fields', () {
      expect(exception.paramName, equals(paramName));
      expect(exception.expectedType, equals(expectedType));
      expect(exception.actualType, equals(actualType));
    });

    test('toString() works correctly', () {
      expect(
        exception.toString(),
        equals(
          'Parameter name is supposed to have type String '
          'but actually has type bool.',
        ),
      );
    });
  });

  group('CollectionApiRepository', () {
    late CollectionApiRepository repository;

    setUp(() {
      repository = MockCollectionApiRepository<Object>(paramDefs: {
        'integer': int,
        'text': String,
        'integer2': int,
        'list': List<double>,
      });
    });

    group('validateParams', () {
      test('throws an exception if one of the params has the wrong type', () {
        expect(
          () => repository.validateParams({
            'integer': 1,
            'text': 2,
            'integer2': 3,
            'list': <double>[4, 5, 6],
          }),
          throwsA(isA<CollectionParamsInvalidException<Object>>()),
        );
      });

      test('completes without throwing if no params are provided', () {
        expect(() => repository.validateParams({}), returnsNormally);
      });

      test('completes without throwing if all params are null', () {
        expect(
          () => repository.validateParams({
            'integer': null,
            'text': null,
            'integer2': null,
            'list': null,
          }),
          returnsNormally,
        );
      });

      test(
        'completes without throwing '
        'if one of the parameters has the wrong name',
        () {
          expect(
            () => repository.validateParams({
              'wrongName': '57',
            }),
            returnsNormally,
          );
        },
      );

      test(
        'completes without throwing if all parameters have the correct type',
        () {
          expect(
            () => repository.validateParams({
              'integer': 1,
              'text': '2',
              'integer2': 3,
              'list': <double>[4, 5, 6],
            }),
            returnsNormally,
          );
        },
      );
    });
  });
}
