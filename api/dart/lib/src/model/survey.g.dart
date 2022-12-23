// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Survey _$SurveyFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Survey',
      json,
      ($checkedConvert) {
        final val = Survey(
          version: $checkedConvert('version', (v) => v as String?),
          sections: $checkedConvert(
              'sections',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => SurveySection.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SurveyToJson(Survey instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('version', instance.version);
  writeNotNull('sections', instance.sections?.map((e) => e.toJson()).toList());
  return val;
}
