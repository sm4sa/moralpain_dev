import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';

// tests for Survey
void main() {
  final json = '''{
	  "version": "0.0.1",
	  "sections": [
	  	{
	  		"sectionId": "001",
	  		"title": "King of the Hill",
	  		"subtitle": "",
	  		"options": [
	  			{
	  				"id": "Hank Hill",
	  				"description": "Propane and Propane Accessories Salesman"
	  			}
	  		]
      }
	  ]
  }''';
  final instance = standardSerializers.fromJson(Survey.serializer, json)!;

  group(Survey, () {
    // String version
    test('to test the property `version`', () async {
      expect("0.0.1", instance.version);
    });

    // BuiltList<SurveySection> sections
    test('to test the property `sections`', () async {
      expect(1, instance.sections!.length);
      expect("King of the Hill", instance.sections!.first.title);
      expect(1, instance.sections!.first.options!.length);
      expect("Hank Hill", instance.sections!.first.options!.first.id!);
    });
  });
}
