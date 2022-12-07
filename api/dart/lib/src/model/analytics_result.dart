//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
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
@BuiltValue()
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

  factory AnalyticsResult([void updates(AnalyticsResultBuilder b)]) = _$AnalyticsResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AnalyticsResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AnalyticsResult> get serializer => _$AnalyticsResultSerializer();
}

class _$AnalyticsResultSerializer implements PrimitiveSerializer<AnalyticsResult> {
  @override
  final Iterable<Type> types = const [AnalyticsResult, _$AnalyticsResult];

  @override
  final String wireName = r'AnalyticsResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AnalyticsResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.operation != null) {
      yield r'operation';
      yield serializers.serialize(
        object.operation,
        specifiedType: const FullType(AnalyticsResultOperationEnum),
      );
    }
    if (object.result != null) {
      yield r'result';
      yield serializers.serialize(
        object.result,
        specifiedType: const FullType(num),
      );
    }
    if (object.error != null) {
      yield r'error';
      yield serializers.serialize(
        object.error,
        specifiedType: const FullType(bool),
      );
    }
    if (object.errormsg != null) {
      yield r'errormsg';
      yield serializers.serialize(
        object.errormsg,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AnalyticsResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AnalyticsResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AnalyticsResultOperationEnum),
          ) as AnalyticsResultOperationEnum;
          result.operation = valueDes;
          break;
        case r'result':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.result = valueDes;
          break;
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.error = valueDes;
          break;
        case r'errormsg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errormsg = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AnalyticsResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AnalyticsResultBuilder();
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

