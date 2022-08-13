//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_timestamp_request.g.dart';

/// SetTimestampRequest
///
/// Properties:
/// * [uuid] 
/// * [timestamp] 
abstract class SetTimestampRequest implements Built<SetTimestampRequest, SetTimestampRequestBuilder> {
    @BuiltValueField(wireName: r'uuid')
    String? get uuid;

    @BuiltValueField(wireName: r'timestamp')
    num? get timestamp;

    SetTimestampRequest._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SetTimestampRequestBuilder b) => b;

    factory SetTimestampRequest([void updates(SetTimestampRequestBuilder b)]) = _$SetTimestampRequest;

    @BuiltValueSerializer(custom: true)
    static Serializer<SetTimestampRequest> get serializer => _$SetTimestampRequestSerializer();
}

class _$SetTimestampRequestSerializer implements StructuredSerializer<SetTimestampRequest> {
    @override
    final Iterable<Type> types = const [SetTimestampRequest, _$SetTimestampRequest];

    @override
    final String wireName = r'SetTimestampRequest';

    @override
    Iterable<Object?> serialize(Serializers serializers, SetTimestampRequest object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.uuid != null) {
            result
                ..add(r'uuid')
                ..add(serializers.serialize(object.uuid,
                    specifiedType: const FullType(String)));
        }
        if (object.timestamp != null) {
            result
                ..add(r'timestamp')
                ..add(serializers.serialize(object.timestamp,
                    specifiedType: const FullType(num)));
        }
        return result;
    }

    @override
    SetTimestampRequest deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SetTimestampRequestBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'uuid':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.uuid = valueDes;
                    break;
                case r'timestamp':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.timestamp = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

