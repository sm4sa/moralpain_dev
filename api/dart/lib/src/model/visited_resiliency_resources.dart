//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'visited_resiliency_resources.g.dart';

/// VisitedResiliencyResources
///
/// Properties:
/// * [selections] 
/// * [timestamp] 
@BuiltValue()
abstract class VisitedResiliencyResources implements Built<VisitedResiliencyResources, VisitedResiliencyResourcesBuilder> {
  @BuiltValueField(wireName: r'selections')
  BuiltList<String>? get selections;

  @BuiltValueField(wireName: r'timestamp')
  int? get timestamp;

  VisitedResiliencyResources._();

  factory VisitedResiliencyResources([void updates(VisitedResiliencyResourcesBuilder b)]) = _$VisitedResiliencyResources;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VisitedResiliencyResourcesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VisitedResiliencyResources> get serializer => _$VisitedResiliencyResourcesSerializer();
}

class _$VisitedResiliencyResourcesSerializer implements PrimitiveSerializer<VisitedResiliencyResources> {
  @override
  final Iterable<Type> types = const [VisitedResiliencyResources, _$VisitedResiliencyResources];

  @override
  final String wireName = r'VisitedResiliencyResources';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VisitedResiliencyResources object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.selections != null) {
      yield r'selections';
      yield serializers.serialize(
        object.selections,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    VisitedResiliencyResources object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VisitedResiliencyResourcesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'selections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.selections.replace(valueDes);
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.timestamp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VisitedResiliencyResources deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VisitedResiliencyResourcesBuilder();
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

