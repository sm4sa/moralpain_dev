//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:moralpainapi/src/model/resiliency_resource.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'resiliency_resources.g.dart';

/// ResiliencyResources
///
/// Properties:
/// * [version] 
/// * [resources] 
@BuiltValue()
abstract class ResiliencyResources implements Built<ResiliencyResources, ResiliencyResourcesBuilder> {
  @BuiltValueField(wireName: r'version')
  String? get version;

  @BuiltValueField(wireName: r'resources')
  BuiltList<ResiliencyResource>? get resources;

  ResiliencyResources._();

  factory ResiliencyResources([void updates(ResiliencyResourcesBuilder b)]) = _$ResiliencyResources;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResiliencyResourcesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResiliencyResources> get serializer => _$ResiliencyResourcesSerializer();
}

class _$ResiliencyResourcesSerializer implements PrimitiveSerializer<ResiliencyResources> {
  @override
  final Iterable<Type> types = const [ResiliencyResources, _$ResiliencyResources];

  @override
  final String wireName = r'ResiliencyResources';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResiliencyResources object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.version != null) {
      yield r'version';
      yield serializers.serialize(
        object.version,
        specifiedType: const FullType(String),
      );
    }
    if (object.resources != null) {
      yield r'resources';
      yield serializers.serialize(
        object.resources,
        specifiedType: const FullType(BuiltList, [FullType(ResiliencyResource)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResiliencyResources object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResiliencyResourcesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.version = valueDes;
          break;
        case r'resources':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ResiliencyResource)]),
          ) as BuiltList<ResiliencyResource>;
          result.resources.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResiliencyResources deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResiliencyResourcesBuilder();
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

