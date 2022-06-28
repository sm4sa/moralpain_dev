//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:moralpainapi/src/model/submission.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submissions.g.dart';

/// Submissions
abstract class Submissions implements Built<Submissions, SubmissionsBuilder> {
    Submissions._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SubmissionsBuilder b) => b;

    factory Submissions([void updates(SubmissionsBuilder b)]) = _$Submissions;

    @BuiltValueSerializer(custom: true)
    static Serializer<Submissions> get serializer => _$SubmissionsSerializer();
}

class _$SubmissionsSerializer implements StructuredSerializer<Submissions> {
    @override
    final Iterable<Type> types = const [Submissions, _$Submissions];

    @override
    final String wireName = r'Submissions';

    @override
    Iterable<Object?> serialize(Serializers serializers, Submissions object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        return result;
    }

    @override
    Submissions deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SubmissionsBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
            }
        }
        return result.build();
    }
}

