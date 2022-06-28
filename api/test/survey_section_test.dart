import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';

// tests for SurveySection
void main() {
  final json = '''{ 
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
  final instance =
      standardSerializers.fromJson(SurveySection.serializer, json)!;

  group(SurveySection, () {
    // String sectionId
    test('to test the property `sectionId`', () async {
      expect("123", instance.sectionId);
    });

    // String title
    test('to test the property `title`', () async {
      expect("Star Wars: Episode IV", instance.title);
    });

    // String subtitle
    test('to test the property `subtitle`', () async {
      expect("A New Hope", instance.subtitle);
    });

    // BuiltList<SurveyOption> options
    test('to test the property `options`', () async {
      expect(2, instance.options!.length);
      expect("foo", instance.options!.first.id);
    });
  });
}
