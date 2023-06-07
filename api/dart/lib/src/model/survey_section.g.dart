// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveySection _$SurveySectionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SurveySection',
      json,
      ($checkedConvert) {
        final val = SurveySection(
          sectionId: $checkedConvert('sectionId', (v) => v as String?),
          title: $checkedConvert('title', (v) => v as String?),
          subtitle: $checkedConvert('subtitle', (v) => v as String?),
          options: $checkedConvert(
              'options',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => SurveyOption.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SurveySectionToJson(SurveySection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sectionId', instance.sectionId);
  writeNotNull('title', instance.title);
  writeNotNull('subtitle', instance.subtitle);
  writeNotNull('options', instance.options?.map((e) => e.toJson()).toList());
  return val;
}
