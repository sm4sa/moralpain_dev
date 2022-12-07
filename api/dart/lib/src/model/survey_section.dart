//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:moralpainapi/src/model/survey_option.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'survey_section.g.dart';

/// SurveySection
///
/// Properties:
/// * [sectionId] 
/// * [title] 
/// * [subtitle] 
/// * [options] 
@BuiltValue()
abstract class SurveySection implements Built<SurveySection, SurveySectionBuilder> {
  @BuiltValueField(wireName: r'sectionId')
  String? get sectionId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'subtitle')
  String? get subtitle;

  @BuiltValueField(wireName: r'options')
  BuiltList<SurveyOption>? get options;

  SurveySection._();

  factory SurveySection([void updates(SurveySectionBuilder b)]) = _$SurveySection;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SurveySectionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SurveySection> get serializer => _$SurveySectionSerializer();
}

class _$SurveySectionSerializer implements PrimitiveSerializer<SurveySection> {
  @override
  final Iterable<Type> types = const [SurveySection, _$SurveySection];

  @override
  final String wireName = r'SurveySection';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SurveySection object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.sectionId != null) {
      yield r'sectionId';
      yield serializers.serialize(
        object.sectionId,
        specifiedType: const FullType(String),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.subtitle != null) {
      yield r'subtitle';
      yield serializers.serialize(
        object.subtitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.options != null) {
      yield r'options';
      yield serializers.serialize(
        object.options,
        specifiedType: const FullType(BuiltList, [FullType(SurveyOption)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SurveySection object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SurveySectionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sectionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sectionId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'subtitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subtitle = valueDes;
          break;
        case r'options':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SurveyOption)]),
          ) as BuiltList<SurveyOption>;
          result.options.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SurveySection deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SurveySectionBuilder();
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

