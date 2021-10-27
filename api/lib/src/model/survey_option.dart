//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'survey_option.g.dart';

/// SurveyOption
///
/// Properties:
/// * [id]
/// * [description]
abstract class SurveyOption
    implements Built<SurveyOption, SurveyOptionBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'description')
  String? get description;

  SurveyOption._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SurveyOptionBuilder b) => b;

  factory SurveyOption([void updates(SurveyOptionBuilder b)]) = _$SurveyOption;

  @BuiltValueSerializer(custom: true)
  static Serializer<SurveyOption> get serializer => _$SurveyOptionSerializer();
}

class _$SurveyOptionSerializer implements StructuredSerializer<SurveyOption> {
  @override
  final Iterable<Type> types = const [SurveyOption, _$SurveyOption];

  @override
  final String wireName = r'SurveyOption';

  @override
  Iterable<Object?> serialize(Serializers serializers, SurveyOption object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    if (object.id != null) {
      result
        ..add(r'id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.description != null) {
      result
        ..add(r'description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SurveyOption deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = SurveyOptionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.id = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.description = valueDes;
          break;
      }
    }
    return result.build();
  }
}
