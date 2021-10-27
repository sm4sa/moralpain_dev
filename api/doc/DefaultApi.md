# moralpainapi.api.DefaultApi

## Load the API package
```dart
import 'package:moralpainapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getSurvey**](DefaultApi.md#getsurvey) | **GET** /survey | Fetch moral distress survey
[**submitSurvey**](DefaultApi.md#submitsurvey) | **POST** /survey | Submit completed moral distress survey


# **getSurvey**
> Survey getSurvey()

Fetch moral distress survey

### Example
```dart
import 'package:moralpainapi/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.getSurvey();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->getSurvey: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Survey**](Survey.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitSurvey**
> String submitSurvey(submission)

Submit completed moral distress survey

### Example
```dart
import 'package:moralpainapi/api.dart';

final api_instance = DefaultApi();
final submission = Submission(); // Submission | 

try {
    final result = api_instance.submitSurvey(submission);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->submitSurvey: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **submission** | [**Submission**](Submission.md)|  | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

