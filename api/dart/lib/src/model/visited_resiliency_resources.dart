//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'visited_resiliency_resources.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VisitedResiliencyResources {
  /// Returns a new [VisitedResiliencyResources] instance.
  VisitedResiliencyResources({

     this.selections,

     this.timestamp,
  });

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



  @override
  bool operator ==(Object other) => identical(this, other) || other is VisitedResiliencyResources &&
     other.selections == selections &&
     other.timestamp == timestamp;

  @override
  int get hashCode =>
    selections.hashCode +
    timestamp.hashCode;

  factory VisitedResiliencyResources.fromJson(Map<String, dynamic> json) => _$VisitedResiliencyResourcesFromJson(json);

  Map<String, dynamic> toJson() => _$VisitedResiliencyResourcesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

