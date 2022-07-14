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
/// * [result] 
/// * [error] 
/// * [errormsg] 
abstract class AnalyticsResult implements Built<AnalyticsResult, AnalyticsResultBuilder> {
    @BuiltValueField(wireName: r'operation')
    AnalyticsResultOperationEnum? get operation;
    // enum operationEnum {  average,  count,  maximum,  minimum,  };

    @BuiltValueField(wireName: r'result')
    num? get result;

    @BuiltValueField(wireName: r'error')
    bool? get error;

    @BuiltValueField(wireName: r'errormsg')
    String? get errormsg;

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
        if (object.result != null) {
            result
                ..add(r'result')
                ..add(serializers.serialize(object.result,
                    specifiedType: const FullType(num)));
        }
        if (object.error != null) {
            result
                ..add(r'error')
                ..add(serializers.serialize(object.error,
                    specifiedType: const FullType(bool)));
        }
        if (object.errormsg != null) {
            result
                ..add(r'errormsg')
                ..add(serializers.serialize(object.errormsg,
                    specifiedType: const FullType(String)));
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
                case r'result':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.result = valueDes;
                    break;
                case r'error':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.error = valueDes;
                    break;
                case r'errormsg':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.errormsg = valueDes;
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

