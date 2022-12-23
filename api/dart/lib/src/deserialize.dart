import 'package:moralpainapi/src/model/analytics_result.dart';
import 'package:moralpainapi/src/model/icon.dart';
import 'package:moralpainapi/src/model/resiliency_resource.dart';
import 'package:moralpainapi/src/model/resiliency_resources.dart';
import 'package:moralpainapi/src/model/submission.dart';
import 'package:moralpainapi/src/model/submissions.dart';
import 'package:moralpainapi/src/model/survey.dart';
import 'package:moralpainapi/src/model/survey_option.dart';
import 'package:moralpainapi/src/model/survey_section.dart';
import 'package:moralpainapi/src/model/visited_resiliency_resources.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

  ReturnType deserialize<ReturnType, BaseType>(dynamic value, String targetType, {bool growable= true}) {
      switch (targetType) {
        case 'String':
          return '$value' as ReturnType;
        case 'int':
          return (value is int ? value : int.parse('$value')) as ReturnType;
        case 'bool':
          if (value is bool) {
            return value as ReturnType;
          }
          final valueString = '$value'.toLowerCase();
          return (valueString == 'true' || valueString == '1') as ReturnType;
        case 'double':
          return (value is double ? value : double.parse('$value')) as ReturnType;
        case 'AnalyticsResult':
          return AnalyticsResult.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Icon':
          return Icon.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ResiliencyResource':
          return ResiliencyResource.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ResiliencyResources':
          return ResiliencyResources.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Submission':
          return Submission.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Submissions':
          return Submissions.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Survey':
          return Survey.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SurveyOption':
          return SurveyOption.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SurveySection':
          return SurveySection.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'VisitedResiliencyResources':
          return VisitedResiliencyResources.fromJson(value as Map<String, dynamic>) as ReturnType;
        default:
          RegExpMatch? match;

          if (value is List && (match = _regList.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toList(growable: growable) as ReturnType;
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toSet() as ReturnType;
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return Map<dynamic, BaseType>.fromIterables(
              value.keys,
              value.values.map((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable)),
            ) as ReturnType;
          }
          break;
    } 
    throw Exception('Cannot deserialize');
  }