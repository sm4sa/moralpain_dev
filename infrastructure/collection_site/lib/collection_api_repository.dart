import 'package:moralpainapi/moralpainapi.dart';

class CollectionFetchFailure<T> implements Exception {
  final String message;

  const CollectionFetchFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  @override
  String toString() {
    return 'CollectionFetchFailure<$T>{message: $message}';
  }
}

class CollectionParamsInvalidException<T> implements Exception {
  final String paramName;
  final Type expectedType;
  final Type actualType;

  const CollectionParamsInvalidException({
    required this.paramName,
    required this.expectedType,
    required this.actualType,
  });

  @override
  String toString() {
    return 'Parameter $paramName is supposed to have type $expectedType '
        'but actually has type $actualType.';
  }
}

abstract class CollectionApiRepository<T> {
  final Map<String, Type> paramDefs;
  late Moralpainapi mapi;

  CollectionApiRepository({
    required this.paramDefs,
    String? basePathOverride,
  }) {
    mapi = Moralpainapi(
        basePathOverride: basePathOverride ??
            'https://umd7orqgt1.execute-api.us-east-1.amazonaws.com/v1');
    mapi.dio.options.connectTimeout = 30 * 1000;
    mapi.dio.options.receiveTimeout = 30 * 1000;
    mapi.dio.options.sendTimeout = 30 * 1000;
  }

  Future<List<T>> fetchCollection(Map<String, dynamic> params);

  void validateParams(Map<String, dynamic> params) {
    paramDefs.forEach((name, type) {
      if (params.containsKey(name) &&
          params[name] != null &&
          params[name].runtimeType != type) {
        throw CollectionParamsInvalidException(
          paramName: name,
          expectedType: paramDefs[name]!,
          actualType: params[name].runtimeType,
        );
      }
    });
  }
}
