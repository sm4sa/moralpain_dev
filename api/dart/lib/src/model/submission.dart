//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'submission.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Submission {
  /// Returns a new [Submission] instance.
  Submission({

     this.score,

     this.selections,

     this.timestamp,

     this.id,
  });

  @JsonKey(
    
    name: r'score',
    required: false,
    includeIfNull: false
  )


  final int? score;



  @JsonKey(
    
    name: r'selections',
    required: false,
    includeIfNull: false
  )


  final List<String>? selections;



  @JsonKey(
    
    name: r'timestamp',
    required: false,
    includeIfNull: false
  )


  final int? timestamp;



  @JsonKey(
    
    name: r'id',
    required: false,
    includeIfNull: false
  )


  final String? id;



  @override
  bool operator ==(Object other) => identical(this, other) || other is Submission &&
     other.score == score &&
     other.selections == selections &&
     other.timestamp == timestamp &&
     other.id == id;

  @override
  int get hashCode =>
    score.hashCode +
    selections.hashCode +
    timestamp.hashCode +
    id.hashCode;

  factory Submission.fromJson(Map<String, dynamic> json) => _$SubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

