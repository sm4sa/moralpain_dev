import 'package:test/test.dart';
import 'package:moralpainapi/moralpainapi.dart';

// tests for Submission
void main() {
  final json = '''
    {
      "score": 9,
      "selections": [
        "001",
        "002"
      ],
      "timestamp": 0,
      "id": "foo"
    }
  ''';
  final instance = standardSerializers.fromJson(Submission.serializer, json)!;

  group(Submission, () {
    // int score
    test('to test the property `score`', () async {
      expect(9, instance.score);
    });

    // BuiltList<String> selections
    test('to test the property `selections`', () async {
      expect(2, instance.selections!.length);
    });

    // int timestamp
    test('to test the property `timestamp`', () async {
      expect(0, instance.timestamp);
    });

    // String id
    test('to test the property `id`', () async {
      expect("foo", instance.id);
    });
  });
}
