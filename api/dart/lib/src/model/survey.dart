//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:moralpainapi/src/model/survey_section.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'survey.g.dart';

/// Survey
///
/// Properties:
/// * [version] 
/// * [sections] 
@BuiltValue()
abstract class Survey implements Built<Survey, SurveyBuilder> {
  @BuiltValueField(wireName: r'version')
  String? get version;

  @BuiltValueField(wireName: r'sections')
  BuiltList<SurveySection>? get sections;

  Survey._();

  factory Survey([void updates(SurveyBuilder b)]) = _$Survey;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SurveyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Survey> get serializer => _$SurveySerializer();
}

class _$SurveySerializer implements PrimitiveSerializer<Survey> {
  @override
  final Iterable<Type> types = const [Survey, _$Survey];

  @override
  final String wireName = r'Survey';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Survey object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.version != null) {
      yield r'version';
      yield serializers.serialize(
        object.version,
        specifiedType: const FullType(String),
      );
    }
    if (object.sections != null) {
      yield r'sections';
      yield serializers.serialize(
        object.sections,
        specifiedType: const FullType(BuiltList, [FullType(SurveySection)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Survey object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SurveyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.version = valueDes;
          break;
        case r'sections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SurveySection)]),
          ) as BuiltList<SurveySection>;
          result.sections.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Survey deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SurveyBuilder();
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

