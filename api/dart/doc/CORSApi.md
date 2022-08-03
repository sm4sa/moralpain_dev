# moralpainapi.api.CORSApi

## Load the API package
```dart
import 'package:moralpainapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**optionsAdminAnalytics**](CORSApi.md#optionsadminanalytics) | **OPTIONS** /admin/analytics | CORS admin analytics support
[**optionsAdminSubmissions**](CORSApi.md#optionsadminsubmissions) | **OPTIONS** /admin/submissions | CORS admin submissions support
[**optionsSurvey**](CORSApi.md#optionssurvey) | **OPTIONS** /survey | CORS survey support
[**optionsVisitedResiliencyResources**](CORSApi.md#optionsvisitedresiliencyresources) | **OPTIONS** /resiliency | CORS resiliency resources support


# **optionsAdminAnalytics**
> optionsAdminAnalytics()

CORS admin analytics support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getCORSApi();

try {
    api.optionsAdminAnalytics();
} catch on DioError (e) {
    print('Exception when calling CORSApi->optionsAdminAnalytics: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **optionsAdminSubmissions**
> optionsAdminSubmissions()

CORS admin submissions support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getCORSApi();

try {
    api.optionsAdminSubmissions();
} catch on DioError (e) {
    print('Exception when calling CORSApi->optionsAdminSubmissions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **optionsSurvey**
> optionsSurvey()

CORS survey support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getCORSApi();

try {
    api.optionsSurvey();
} catch on DioError (e) {
    print('Exception when calling CORSApi->optionsSurvey: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **optionsVisitedResiliencyResources**
> optionsVisitedResiliencyResources()

CORS resiliency resources support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getCORSApi();

try {
    api.optionsVisitedResiliencyResources();
} catch on DioError (e) {
    print('Exception when calling CORSApi->optionsVisitedResiliencyResources: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

