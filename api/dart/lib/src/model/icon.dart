//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'icon.g.dart';

/// Icon
///
/// Properties:
/// * [codePoint] 
/// * [fontFamily] 
/// * [fontPackage] 
@BuiltValue()
abstract class Icon implements Built<Icon, IconBuilder> {
  @BuiltValueField(wireName: r'codePoint')
  String? get codePoint;

  @BuiltValueField(wireName: r'fontFamily')
  String? get fontFamily;

  @BuiltValueField(wireName: r'fontPackage')
  String? get fontPackage;

  Icon._();

  factory Icon([void updates(IconBuilder b)]) = _$Icon;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IconBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Icon> get serializer => _$IconSerializer();
}

class _$IconSerializer implements PrimitiveSerializer<Icon> {
  @override
  final Iterable<Type> types = const [Icon, _$Icon];

  @override
  final String wireName = r'Icon';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Icon object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.codePoint != null) {
      yield r'codePoint';
      yield serializers.serialize(
        object.codePoint,
        specifiedType: const FullType(String),
      );
    }
    if (object.fontFamily != null) {
      yield r'fontFamily';
      yield serializers.serialize(
        object.fontFamily,
        specifiedType: const FullType(String),
      );
    }
    if (object.fontPackage != null) {
      yield r'fontPackage';
      yield serializers.serialize(
        object.fontPackage,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Icon object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IconBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'codePoint':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.codePoint = valueDes;
          break;
        case r'fontFamily':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fontFamily = valueDes;
          break;
        case r'fontPackage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fontPackage = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Icon deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IconBuilder();
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

