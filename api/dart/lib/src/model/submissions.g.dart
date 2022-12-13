// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Submissions _$SubmissionsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Submissions',
      json,
      ($checkedConvert) {
        final val = Submissions(
          list: $checkedConvert(
              'list',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Submission.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SubmissionsToJson(Submissions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('list', instance.list?.map((e) => e.toJson()).toList());
  return val;
}
