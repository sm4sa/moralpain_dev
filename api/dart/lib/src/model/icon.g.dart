// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Icon _$IconFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Icon',
      json,
      ($checkedConvert) {
        final val = Icon(
          codePoint: $checkedConvert('codePoint', (v) => v as String?),
          fontFamily: $checkedConvert('fontFamily', (v) => v as String?),
          fontPackage: $checkedConvert('fontPackage', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$IconToJson(Icon instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('codePoint', instance.codePoint);
  writeNotNull('fontFamily', instance.fontFamily);
  writeNotNull('fontPackage', instance.fontPackage);
  return val;
}
