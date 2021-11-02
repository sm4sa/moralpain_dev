//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

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

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SurveySectionBuilder b) => b;

    factory SurveySection([void updates(SurveySectionBuilder b)]) = _$SurveySection;

    @BuiltValueSerializer(custom: true)
    static Serializer<SurveySection> get serializer => _$SurveySectionSerializer();
}

class _$SurveySectionSerializer implements StructuredSerializer<SurveySection> {
    @override
    final Iterable<Type> types = const [SurveySection, _$SurveySection];

    @override
    final String wireName = r'SurveySection';

    @override
    Iterable<Object?> serialize(Serializers serializers, SurveySection object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.sectionId != null) {
            result
                ..add(r'sectionId')
                ..add(serializers.serialize(object.sectionId,
                    specifiedType: const FullType(String)));
        }
        if (object.title != null) {
            result
                ..add(r'title')
                ..add(serializers.serialize(object.title,
                    specifiedType: const FullType(String)));
        }
        if (object.subtitle != null) {
            result
                ..add(r'subtitle')
                ..add(serializers.serialize(object.subtitle,
                    specifiedType: const FullType(String)));
        }
        if (object.options != null) {
            result
                ..add(r'options')
                ..add(serializers.serialize(object.options,
                    specifiedType: const FullType(BuiltList, [FullType(SurveyOption)])));
        }
        return result;
    }

    @override
    SurveySection deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SurveySectionBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'sectionId':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.sectionId = valueDes;
                    break;
                case r'title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.title = valueDes;
                    break;
                case r'subtitle':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.subtitle = valueDes;
                    break;
                case r'options':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(SurveyOption)])) as BuiltList<SurveyOption>;
                    result.options.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

