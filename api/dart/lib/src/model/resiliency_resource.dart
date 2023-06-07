//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:moralpainapi/src/model/icon.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resiliency_resource.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ResiliencyResource {
  /// Returns a new [ResiliencyResource] instance.
  ResiliencyResource({

     this.resourceId,

     this.title,

     this.description,

     this.url,

     this.icon,
  });

  @JsonKey(
    
    name: r'resourceId',
    required: false,
    includeIfNull: false
  )


  final String? resourceId;



  @JsonKey(
    
    name: r'title',
    required: false,
    includeIfNull: false
  )


  final String? title;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false
  )


  final String? description;



  @JsonKey(
    
    name: r'url',
    required: false,
    includeIfNull: false
  )


  final String? url;



  @JsonKey(
    
    name: r'icon',
    required: false,
    includeIfNull: false
  )


  final Icon? icon;



  @override
  bool operator ==(Object other) => identical(this, other) || other is ResiliencyResource &&
     other.resourceId == resourceId &&
     other.title == title &&
     other.description == description &&
     other.url == url &&
     other.icon == icon;

  @override
  int get hashCode =>
    resourceId.hashCode +
    title.hashCode +
    description.hashCode +
    url.hashCode +
    icon.hashCode;

  factory ResiliencyResource.fromJson(Map<String, dynamic> json) => _$ResiliencyResourceFromJson(json);

  Map<String, dynamic> toJson() => _$ResiliencyResourceToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

