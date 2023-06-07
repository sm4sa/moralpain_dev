// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsResult _$AnalyticsResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AnalyticsResult',
      json,
      ($checkedConvert) {
        final val = AnalyticsResult(
          operation: $checkedConvert(
              'operation',
              (v) => $enumDecodeNullable(
                  _$AnalyticsResultOperationEnumEnumMap, v)),
          result: $checkedConvert('result', (v) => v as num?),
          error: $checkedConvert('error', (v) => v as bool?),
          errormsg: $checkedConvert('errormsg', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$AnalyticsResultToJson(AnalyticsResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'operation', _$AnalyticsResultOperationEnumEnumMap[instance.operation]);
  writeNotNull('result', instance.result);
  writeNotNull('error', instance.error);
  writeNotNull('errormsg', instance.errormsg);
  return val;
}

const _$AnalyticsResultOperationEnumEnumMap = {
  AnalyticsResultOperationEnum.average: 'average',
  AnalyticsResultOperationEnum.count: 'count',
  AnalyticsResultOperationEnum.maximum: 'maximum',
  AnalyticsResultOperationEnum.minimum: 'minimum',
};
