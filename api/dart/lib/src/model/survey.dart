//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:moralpainapi/src/model/survey_section.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Survey {
  /// Returns a new [Survey] instance.
  Survey({

     this.version,

     this.sections,
  });

  @JsonKey(
    
    name: r'version',
    required: false,
    includeIfNull: false
  )


  final String? version;



  @JsonKey(
    
    name: r'sections',
    required: false,
    includeIfNull: false
  )


  final List<SurveySection>? sections;



  @override
  bool operator ==(Object other) => identical(this, other) || other is Survey &&
     other.version == version &&
     other.sections == sections;

  @override
  int get hashCode =>
    version.hashCode +
    sections.hashCode;

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

