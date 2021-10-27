//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

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
abstract class Survey implements Built<Survey, SurveyBuilder> {
    @BuiltValueField(wireName: r'version')
    String? get version;

    @BuiltValueField(wireName: r'sections')
    BuiltList<SurveySection>? get sections;

    Survey._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SurveyBuilder b) => b;

    factory Survey([void updates(SurveyBuilder b)]) = _$Survey;

    @BuiltValueSerializer(custom: true)
    static Serializer<Survey> get serializer => _$SurveySerializer();
}

class _$SurveySerializer implements StructuredSerializer<Survey> {
    @override
    final Iterable<Type> types = const [Survey, _$Survey];

    @override
    final String wireName = r'Survey';

    @override
    Iterable<Object?> serialize(Serializers serializers, Survey object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.version != null) {
            result
                ..add(r'version')
                ..add(serializers.serialize(object.version,
                    specifiedType: const FullType(String)));
        }
        if (object.sections != null) {
            result
                ..add(r'sections')
                ..add(serializers.serialize(object.sections,
                    specifiedType: const FullType(BuiltList, [FullType(SurveySection)])));
        }
        return result;
    }

    @override
    Survey deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SurveyBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'version':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.version = valueDes;
                    break;
                case r'sections':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(SurveySection)])) as BuiltList<SurveySection>;
                    result.sections.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

