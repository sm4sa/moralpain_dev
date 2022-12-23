// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Submission _$SubmissionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Submission',
      json,
      ($checkedConvert) {
        final val = Submission(
          score: $checkedConvert('score', (v) => v as int?),
          selections: $checkedConvert('selections',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          timestamp: $checkedConvert('timestamp', (v) => v as int?),
          id: $checkedConvert('id', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$SubmissionToJson(Submission instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('score', instance.score);
  writeNotNull('selections', instance.selections);
  writeNotNull('timestamp', instance.timestamp);
  writeNotNull('id', instance.id);
  return val;
}
