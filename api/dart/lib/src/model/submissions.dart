//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:moralpainapi/src/model/submission.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submissions.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Submissions {
  /// Returns a new [Submissions] instance.
  Submissions({

     this.list,
  });

  @JsonKey(
    
    name: r'list',
    required: false,
    includeIfNull: false
  )


  final List<Submission>? list;



  @override
  bool operator ==(Object other) => identical(this, other) || other is Submissions &&
     other.list == list;

  @override
  int get hashCode =>
    list.hashCode;

  factory Submissions.fromJson(Map<String, dynamic> json) => _$SubmissionsFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

