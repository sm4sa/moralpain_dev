// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyOption _$SurveyOptionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SurveyOption',
      json,
      ($checkedConvert) {
        final val = SurveyOption(
          id: $checkedConvert('id', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$SurveyOptionToJson(SurveyOption instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('description', instance.description);
  return val;
}
