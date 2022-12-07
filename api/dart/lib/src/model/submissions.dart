//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:moralpainapi/src/model/submission.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submissions.g.dart';

/// Submissions
///
/// Properties:
/// * [list] 
@BuiltValue()
abstract class Submissions implements Built<Submissions, SubmissionsBuilder> {
  @BuiltValueField(wireName: r'list')
  BuiltList<Submission>? get list;

  Submissions._();

  factory Submissions([void updates(SubmissionsBuilder b)]) = _$Submissions;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmissionsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Submissions> get serializer => _$SubmissionsSerializer();
}

class _$SubmissionsSerializer implements PrimitiveSerializer<Submissions> {
  @override
  final Iterable<Type> types = const [Submissions, _$Submissions];

  @override
  final String wireName = r'Submissions';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Submissions object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.list != null) {
      yield r'list';
      yield serializers.serialize(
        object.list,
        specifiedType: const FullType(BuiltList, [FullType(Submission)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Submissions object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmissionsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'list':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Submission)]),
          ) as BuiltList<Submission>;
          result.list.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Submissions deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmissionsBuilder();
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

