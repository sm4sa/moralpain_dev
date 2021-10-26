import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:moralpain/models/question.dart';

void main() {
  test('Decode Question', () {
    var json = '''{ 
      "sectionId": "123", 
      "title": "Star Wars: Episode IV",
      "subtitle": "A New Hope",
      "options": [
        {
          "id": "foo",
          "description": "foo"
        },
        {
          "id": "bar",
          "description": "bar"
        }
      ]
    }''';
    var decoded = jsonDecode(json);
    var question = Question.fromJson(decoded);

    expect(question.sectionId, "123");
    expect(question.title, "Star Wars: Episode IV");
    expect(question.subtitle, "A New Hope");
    expect(question.options.length, 2);
    expect(question.options[0].id, "foo");
    expect(question.options[1].id, "bar");
  });
}
