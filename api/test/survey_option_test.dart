import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'dart:convert';

// tests for SurveyOption
void main() {
  final json = '''
    { 
      "id": "Philip J. Fry",
      "description": "Human" 
    } 
  ''';
  final instance = standardSerializers.fromJson(SurveyOption.serializer, json);

  group(SurveyOption, () {
    // String id
    test('to test the property `id`', () async {
      expect("Philip J. Fry", instance?.id);
    });

    // String description
    test('to test the property `description`', () async {
      expect("Human", instance?.description);
    });
  });
}
