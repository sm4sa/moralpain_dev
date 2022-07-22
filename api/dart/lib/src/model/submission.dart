//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

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

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SubmissionBuilder b) => b;

    factory Submission([void updates(SubmissionBuilder b)]) = _$Submission;

    @BuiltValueSerializer(custom: true)
    static Serializer<Submission> get serializer => _$SubmissionSerializer();
}

class _$SubmissionSerializer implements StructuredSerializer<Submission> {
    @override
    final Iterable<Type> types = const [Submission, _$Submission];

    @override
    final String wireName = r'Submission';

    @override
    Iterable<Object?> serialize(Serializers serializers, Submission object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.score != null) {
            result
                ..add(r'score')
                ..add(serializers.serialize(object.score,
                    specifiedType: const FullType(int)));
        }
        if (object.selections != null) {
            result
                ..add(r'selections')
                ..add(serializers.serialize(object.selections,
                    specifiedType: const FullType(BuiltList, [FullType(String)])));
        }
        if (object.timestamp != null) {
            result
                ..add(r'timestamp')
                ..add(serializers.serialize(object.timestamp,
                    specifiedType: const FullType(int)));
        }
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    Submission deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SubmissionBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'score':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.score = valueDes;
                    break;
                case r'selections':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(String)])) as BuiltList<String>;
                    result.selections.replace(valueDes);
                    break;
                case r'timestamp':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.timestamp = valueDes;
                    break;
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.id = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

