//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'survey_option.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SurveyOption {
  /// Returns a new [SurveyOption] instance.
  SurveyOption({

     this.id,

     this.description,
  });

  @JsonKey(
    
    name: r'id',
    required: false,
    includeIfNull: false
  )


  final String? id;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false
  )


  final String? description;



  @override
  bool operator ==(Object other) => identical(this, other) || other is SurveyOption &&
     other.id == id &&
     other.description == description;

  @override
  int get hashCode =>
    id.hashCode +
    description.hashCode;

  factory SurveyOption.fromJson(Map<String, dynamic> json) => _$SurveyOptionFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyOptionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

