import 'package:flutter/material.dart';

abstract class Collection<T> {
  /// The list of all parameters passed to the API repository.
  /// The keys are the parameter names, and the values are their types.
  final Map<String, Type> paramDefs;

  /// The message displayed when the list fetched from the API repository
  /// is empty.
  final String emptyListMessage;

  /// The message displayed when there is an error fetching the list from the
  /// API repository.
  final String errorMessage;

  const Collection({
    required this.paramDefs,
    required this.emptyListMessage,
    required this.errorMessage,
  });

  /// Calls the correct method in the API repository with the given parameters.
  ///
  /// For [params], the keys are the parameter names, and the values are the
  /// parameter values. This method should throw an error if [paramsAreValid()]
  /// returns false.
  List<T> fetchFromRepository(Map<String, dynamic> params);

  /// Returns a visual representation of the given item in the collection.
  Widget display(T item);
}
