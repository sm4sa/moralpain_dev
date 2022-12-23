// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visited_resiliency_resources.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitedResiliencyResources _$VisitedResiliencyResourcesFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'VisitedResiliencyResources',
      json,
      ($checkedConvert) {
        final val = VisitedResiliencyResources(
          selections: $checkedConvert('selections',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          timestamp: $checkedConvert('timestamp', (v) => v as int?),
        );
        return val;
      },
    );

Map<String, dynamic> _$VisitedResiliencyResourcesToJson(
    VisitedResiliencyResources instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('selections', instance.selections);
  writeNotNull('timestamp', instance.timestamp);
  return val;
}
