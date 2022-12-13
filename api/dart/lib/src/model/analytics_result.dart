//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'analytics_result.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AnalyticsResult {
  /// Returns a new [AnalyticsResult] instance.
  AnalyticsResult({

     this.operation,

     this.result,

     this.error,

     this.errormsg,
  });

  @JsonKey(
    
    name: r'operation',
    required: false,
    includeIfNull: false
  )


  final AnalyticsResultOperationEnum? operation;



  @JsonKey(
    
    name: r'result',
    required: false,
    includeIfNull: false
  )


  final num? result;



  @JsonKey(
    
    name: r'error',
    required: false,
    includeIfNull: false
  )


  final bool? error;



  @JsonKey(
    
    name: r'errormsg',
    required: false,
    includeIfNull: false
  )


  final String? errormsg;



  @override
  bool operator ==(Object other) => identical(this, other) || other is AnalyticsResult &&
     other.operation == operation &&
     other.result == result &&
     other.error == error &&
     other.errormsg == errormsg;

  @override
  int get hashCode =>
    operation.hashCode +
    result.hashCode +
    error.hashCode +
    errormsg.hashCode;

  factory AnalyticsResult.fromJson(Map<String, dynamic> json) => _$AnalyticsResultFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum AnalyticsResultOperationEnum {
  @JsonValue(r'average')
  average,
  @JsonValue(r'count')
  count,
  @JsonValue(r'maximum')
  maximum,
  @JsonValue(r'minimum')
  minimum,
}


