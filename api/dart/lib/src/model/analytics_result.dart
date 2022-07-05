//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'analytics_result.g.dart';

/// AnalyticsResult
///
/// Properties:
/// * [operation] 
/// * [value] 
abstract class AnalyticsResult implements Built<AnalyticsResult, AnalyticsResultBuilder> {
    @BuiltValueField(wireName: r'operation')
    AnalyticsResultOperationEnum? get operation;
    // enum operationEnum {  average,  count,  maximum,  minimum,  };

    @BuiltValueField(wireName: r'value')
    num? get value;

    AnalyticsResult._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AnalyticsResultBuilder b) => b;

    factory AnalyticsResult([void updates(AnalyticsResultBuilder b)]) = _$AnalyticsResult;

    @BuiltValueSerializer(custom: true)
    static Serializer<AnalyticsResult> get serializer => _$AnalyticsResultSerializer();
}

class _$AnalyticsResultSerializer implements StructuredSerializer<AnalyticsResult> {
    @override
    final Iterable<Type> types = const [AnalyticsResult, _$AnalyticsResult];

    @override
    final String wireName = r'AnalyticsResult';

    @override
    Iterable<Object?> serialize(Serializers serializers, AnalyticsResult object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.operation != null) {
            result
                ..add(r'operation')
                ..add(serializers.serialize(object.operation,
                    specifiedType: const FullType(AnalyticsResultOperationEnum)));
        }
        if (object.value != null) {
            result
                ..add(r'value')
                ..add(serializers.serialize(object.value,
                    specifiedType: const FullType(num)));
        }
        return result;
    }

    @override
    AnalyticsResult deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AnalyticsResultBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'operation':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(AnalyticsResultOperationEnum)) as AnalyticsResultOperationEnum;
                    result.operation = valueDes;
                    break;
                case r'value':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.value = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

class AnalyticsResultOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'average')
  static const AnalyticsResultOperationEnum average = _$analyticsResultOperationEnum_average;
  @BuiltValueEnumConst(wireName: r'count')
  static const AnalyticsResultOperationEnum count = _$analyticsResultOperationEnum_count;
  @BuiltValueEnumConst(wireName: r'maximum')
  static const AnalyticsResultOperationEnum maximum = _$analyticsResultOperationEnum_maximum;
  @BuiltValueEnumConst(wireName: r'minimum')
  static const AnalyticsResultOperationEnum minimum = _$analyticsResultOperationEnum_minimum;

  static Serializer<AnalyticsResultOperationEnum> get serializer => _$analyticsResultOperationEnumSerializer;

  const AnalyticsResultOperationEnum._(String name): super(name);

  static BuiltSet<AnalyticsResultOperationEnum> get values => _$analyticsResultOperationEnumValues;
  static AnalyticsResultOperationEnum valueOf(String name) => _$analyticsResultOperationEnumValueOf(name);
}

