//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:moralpainapi/src/model/survey_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_section.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SurveySection {
  /// Returns a new [SurveySection] instance.
  SurveySection({

     this.sectionId,

     this.title,

     this.subtitle,

     this.options,
  });

  @JsonKey(
    
    name: r'sectionId',
    required: false,
    includeIfNull: false
  )


  final String? sectionId;



  @JsonKey(
    
    name: r'title',
    required: false,
    includeIfNull: false
  )


  final String? title;



  @JsonKey(
    
    name: r'subtitle',
    required: false,
    includeIfNull: false
  )


  final String? subtitle;



  @JsonKey(
    
    name: r'options',
    required: false,
    includeIfNull: false
  )


  final List<SurveyOption>? options;



  @override
  bool operator ==(Object other) => identical(this, other) || other is SurveySection &&
     other.sectionId == sectionId &&
     other.title == title &&
     other.subtitle == subtitle &&
     other.options == options;

  @override
  int get hashCode =>
    sectionId.hashCode +
    title.hashCode +
    subtitle.hashCode +
    options.hashCode;

  factory SurveySection.fromJson(Map<String, dynamic> json) => _$SurveySectionFromJson(json);

  Map<String, dynamic> toJson() => _$SurveySectionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

