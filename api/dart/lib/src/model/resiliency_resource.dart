//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:moralpainapi/src/model/icon.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'resiliency_resource.g.dart';

/// ResiliencyResource
///
/// Properties:
/// * [resourceId] 
/// * [title] 
/// * [description] 
/// * [url] 
/// * [icon] 
@BuiltValue()
abstract class ResiliencyResource implements Built<ResiliencyResource, ResiliencyResourceBuilder> {
  @BuiltValueField(wireName: r'resourceId')
  String? get resourceId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'url')
  String? get url;

  @BuiltValueField(wireName: r'icon')
  Icon? get icon;

  ResiliencyResource._();

  factory ResiliencyResource([void updates(ResiliencyResourceBuilder b)]) = _$ResiliencyResource;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResiliencyResourceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResiliencyResource> get serializer => _$ResiliencyResourceSerializer();
}

class _$ResiliencyResourceSerializer implements PrimitiveSerializer<ResiliencyResource> {
  @override
  final Iterable<Type> types = const [ResiliencyResource, _$ResiliencyResource];

  @override
  final String wireName = r'ResiliencyResource';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResiliencyResource object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.resourceId != null) {
      yield r'resourceId';
      yield serializers.serialize(
        object.resourceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.url != null) {
      yield r'url';
      yield serializers.serialize(
        object.url,
        specifiedType: const FullType(String),
      );
    }
    if (object.icon != null) {
      yield r'icon';
      yield serializers.serialize(
        object.icon,
        specifiedType: const FullType(Icon),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResiliencyResource object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResiliencyResourceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'resourceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resourceId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'icon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Icon),
          ) as Icon;
          result.icon.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResiliencyResource deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResiliencyResourceBuilder();
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

