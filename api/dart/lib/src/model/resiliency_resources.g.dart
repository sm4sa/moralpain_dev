// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resiliency_resources.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResiliencyResources _$ResiliencyResourcesFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ResiliencyResources',
      json,
      ($checkedConvert) {
        final val = ResiliencyResources(
          version: $checkedConvert('version', (v) => v as String?),
          resources: $checkedConvert(
              'resources',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      ResiliencyResource.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ResiliencyResourcesToJson(ResiliencyResources instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('version', instance.version);
  writeNotNull(
      'resources', instance.resources?.map((e) => e.toJson()).toList());
  return val;
}
