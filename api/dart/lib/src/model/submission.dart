//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submission.g.dart';

/// Submission
///
/// Properties:
/// * [score] 
/// * [selections] 
/// * [timestamp] 
/// * [id] 
@BuiltValue()
abstract class Submission implements Built<Submission, SubmissionBuilder> {
  @BuiltValueField(wireName: r'score')
  int? get score;

  @BuiltValueField(wireName: r'selections')
  BuiltList<String>? get selections;

  @BuiltValueField(wireName: r'timestamp')
  int? get timestamp;

  @BuiltValueField(wireName: r'id')
  String? get id;

  Submission._();

  factory Submission([void updates(SubmissionBuilder b)]) = _$Submission;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmissionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Submission> get serializer => _$SubmissionSerializer();
}

class _$SubmissionSerializer implements PrimitiveSerializer<Submission> {
  @override
  final Iterable<Type> types = const [Submission, _$Submission];

  @override
  final String wireName = r'Submission';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Submission object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(int),
      );
    }
    if (object.selections != null) {
      yield r'selections';
      yield serializers.serialize(
        object.selections,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType(int),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Submission object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmissionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.score = valueDes;
          break;
        case r'selections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.selections.replace(valueDes);
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.timestamp = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Submission deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmissionBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

