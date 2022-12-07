# moralpainapi.api.SubmissionApi

## Load the API package
```dart
import 'package:moralpainapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getSubmission**](SubmissionApi.md#getsubmission) | **GET** /submission | get the submission
[**submitSubmission**](SubmissionApi.md#submitsubmission) | **POST** /submission | Submit a submission


# **getSubmission**
> Submission getSubmission()

get the submission

Get the MDQ submission. 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getSubmissionApi();

try {
    final response = api.getSubmission();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SubmissionApi->getSubmission: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Submission**](Submission.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitSubmission**
> String submitSubmission(submission)

Submit a submission

Submit 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getSubmissionApi();
final Submission submission = ; // Submission | 

try {
    final response = api.submitSubmission(submission);
    print(response);
} catch on DioError (e) {
    print('Exception when calling SubmissionApi->submitSubmission: $e\n');
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

