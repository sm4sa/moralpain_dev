// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resiliency_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResiliencyResource _$ResiliencyResourceFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ResiliencyResource',
      json,
      ($checkedConvert) {
        final val = ResiliencyResource(
          resourceId: $checkedConvert('resourceId', (v) => v as String?),
          title: $checkedConvert('title', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          url: $checkedConvert('url', (v) => v as String?),
          icon: $checkedConvert(
              'icon',
              (v) =>
                  v == null ? null : Icon.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ResiliencyResourceToJson(ResiliencyResource instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('resourceId', instance.resourceId);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('url', instance.url);
  writeNotNull('icon', instance.icon?.toJson());
  return val;
}
