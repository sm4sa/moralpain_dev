# moralpainapi.api.UserApi

## Load the API package
```dart
import 'package:moralpainapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getResiliencyResources**](UserApi.md#getresiliencyresources) | **GET** /resiliency | Get resiliency resources
[**getSubmission**](UserApi.md#getsubmission) | **GET** /submission | get the submission
[**getSubmissions**](UserApi.md#getsubmissions) | **GET** /submissions | get the submissions
[**getSurvey**](UserApi.md#getsurvey) | **GET** /survey | Get the MDQ
[**submitSubmission**](UserApi.md#submitsubmission) | **POST** /submission | Submit a submission
[**submitSubmissionTypeDB**](UserApi.md#submitsubmissiontypedb) | **POST** /submissions | Submit a submission
[**submitSurvey**](UserApi.md#submitsurvey) | **POST** /survey | Submit a completed MDQ
[**submitVisitedResiliencyResources**](UserApi.md#submitvisitedresiliencyresources) | **POST** /resiliency | Submit visited resiliency resources


# **getResiliencyResources**
> ResiliencyResources getResiliencyResources()

Get resiliency resources

Fetch the recommended resiliency resources from the database. 

### Example
```dart
import 'package:moralpainapi/api.dart';
// TODO Configure API key authorization: sigv4Reference
//defaultApiClient.getAuthentication<ApiKeyAuth>('sigv4Reference').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('sigv4Reference').apiKeyPrefix = 'Bearer';

final api = Moralpainapi().getUserApi();

try {
    final response = api.getResiliencyResources();
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->getResiliencyResources: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ResiliencyResources**](ResiliencyResources.md)

### Authorization

[sigv4Reference](../README.md#sigv4Reference)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSubmission**
> Submission getSubmission()

get the submission

Get the MDQ submission. 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getUserApi();

try {
    final response = api.getSubmission();
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->getSubmission: $e\n');
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

# **getSubmissions**
> Submissions getSubmissions()

get the submissions

Get the MDQ submissions using TypeDB. 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getUserApi();

try {
    final response = api.getSubmissions();
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->getSubmissions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Submissions**](Submissions.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSurvey**
> Survey getSurvey()

Get the MDQ

Fetch the latest moral distress questionnaire (MDQ) from the database. 

### Example
```dart
import 'package:moralpainapi/api.dart';
// TODO Configure API key authorization: sigv4Reference
//defaultApiClient.getAuthentication<ApiKeyAuth>('sigv4Reference').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('sigv4Reference').apiKeyPrefix = 'Bearer';

final api = Moralpainapi().getUserApi();

try {
    final response = api.getSurvey();
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->getSurvey: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Survey**](Survey.md)

### Authorization

[sigv4Reference](../README.md#sigv4Reference)

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

final api = Moralpainapi().getUserApi();
final Submission submission = ; // Submission | 

try {
    final response = api.submitSubmission(submission);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->submitSubmission: $e\n');
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

# **submitSubmissionTypeDB**
> String submitSubmissionTypeDB(submission)

Submit a submission

Submit with TypeDB 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getUserApi();
final Submission submission = ; // Submission | 

try {
    final response = api.submitSubmissionTypeDB(submission);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->submitSubmissionTypeDB: $e\n');
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

# **submitSurvey**
> String submitSurvey(submission)

Submit a completed MDQ

Submit a completed Moral Distress Questionnaire and Moral Distress Score to the database. 

### Example
```dart
import 'package:moralpainapi/api.dart';
// TODO Configure API key authorization: sigv4Reference
//defaultApiClient.getAuthentication<ApiKeyAuth>('sigv4Reference').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('sigv4Reference').apiKeyPrefix = 'Bearer';

final api = Moralpainapi().getUserApi();
final Submission submission = ; // Submission | 

try {
    final response = api.submitSurvey(submission);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->submitSurvey: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **submission** | [**Submission**](Submission.md)|  | [optional] 

### Return type

**String**

### Authorization

[sigv4Reference](../README.md#sigv4Reference)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitVisitedResiliencyResources**
> String submitVisitedResiliencyResources(visitedResiliencyResources)

Submit visited resiliency resources

Submit the list of resources visited by this user to the database. 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getUserApi();
final VisitedResiliencyResources visitedResiliencyResources = ; // VisitedResiliencyResources | 

try {
    final response = api.submitVisitedResiliencyResources(visitedResiliencyResources);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->submitVisitedResiliencyResources: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **visitedResiliencyResources** | [**VisitedResiliencyResources**](VisitedResiliencyResources.md)|  | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

