//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:moralpainapi/src/model/resiliency_resource.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resiliency_resources.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ResiliencyResources {
  /// Returns a new [ResiliencyResources] instance.
  ResiliencyResources({

     this.version,

     this.resources,
  });

  @JsonKey(
    
    name: r'version',
    required: false,
    includeIfNull: false
  )


  final String? version;



  @JsonKey(
    
    name: r'resources',
    required: false,
    includeIfNull: false
  )


  final List<ResiliencyResource>? resources;



  @override
  bool operator ==(Object other) => identical(this, other) || other is ResiliencyResources &&
     other.version == version &&
     other.resources == resources;

  @override
  int get hashCode =>
    version.hashCode +
    resources.hashCode;

  factory ResiliencyResources.fromJson(Map<String, dynamic> json) => _$ResiliencyResourcesFromJson(json);

  Map<String, dynamic> toJson() => _$ResiliencyResourcesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

