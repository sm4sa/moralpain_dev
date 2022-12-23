//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'icon.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Icon {
  /// Returns a new [Icon] instance.
  Icon({

     this.codePoint,

     this.fontFamily,

     this.fontPackage,
  });

  @JsonKey(
    
    name: r'codePoint',
    required: false,
    includeIfNull: false
  )


  final String? codePoint;



  @JsonKey(
    
    name: r'fontFamily',
    required: false,
    includeIfNull: false
  )


  final String? fontFamily;



  @JsonKey(
    
    name: r'fontPackage',
    required: false,
    includeIfNull: false
  )


  final String? fontPackage;



  @override
  bool operator ==(Object other) => identical(this, other) || other is Icon &&
     other.codePoint == codePoint &&
     other.fontFamily == fontFamily &&
     other.fontPackage == fontPackage;

  @override
  int get hashCode =>
    codePoint.hashCode +
    fontFamily.hashCode +
    fontPackage.hashCode;

  factory Icon.fromJson(Map<String, dynamic> json) => _$IconFromJson(json);

  Map<String, dynamic> toJson() => _$IconToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

