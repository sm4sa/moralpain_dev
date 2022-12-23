# moralpainapi.api.AdminApi

## Load the API package
```dart
import 'package:moralpainapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAdminSubmissions**](AdminApi.md#getadminsubmissions) | **GET** /admin/submissions | Get survey results
[**getAnalytics**](AdminApi.md#getanalytics) | **GET** /admin/analytics | Get data analysis


# **getAdminSubmissions**
> Submissions getAdminSubmissions(starttime, endtime, minscore, maxscore, uuid)

Get survey results

Fetch from the database all of the records that match the query parameters. 

### Example
```dart
import 'package:moralpainapi/api.dart';
// TODO Configure API key authorization: sigv4Reference
//defaultApiClient.getAuthentication<ApiKeyAuth>('sigv4Reference').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('sigv4Reference').apiKeyPrefix = 'Bearer';

final api = Moralpainapi().getAdminApi();
final int starttime = 1640995200; // int | Minimum possible timestamp of a record in UTC seconds since Unix epoch.
final int endtime = 1647907200; // int | Maximum possible timestamp of a record in UTC seconds since Unix epoch.
final int minscore = 1; // int | Minimum possible score of a record.
final int maxscore = 5; // int | Maximum possible score of a record.
final String uuid = f2f2011c8d2547849dfce99ae4b75797; // String | If this parameter is specified, all other parameters are ignored and only the submission with the given UUID is fetched. If no such submission exists, an empty list is fetched. 

try {
    final response = api.getAdminSubmissions(starttime, endtime, minscore, maxscore, uuid);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AdminApi->getAdminSubmissions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **starttime** | **int**| Minimum possible timestamp of a record in UTC seconds since Unix epoch. | [optional] 
 **endtime** | **int**| Maximum possible timestamp of a record in UTC seconds since Unix epoch. | [optional] 
 **minscore** | **int**| Minimum possible score of a record. | [optional] 
 **maxscore** | **int**| Maximum possible score of a record. | [optional] 
 **uuid** | **String**| If this parameter is specified, all other parameters are ignored and only the submission with the given UUID is fetched. If no such submission exists, an empty list is fetched.  | [optional] 

### Return type

[**Submissions**](Submissions.md)

### Authorization

[sigv4Reference](../README.md#sigv4Reference)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAnalytics**
> AnalyticsResult getAnalytics(operation, starttime, endtime)

Get data analysis

Perform an analysis on the records in the database that match the query paramters. 

### Example
```dart
import 'package:moralpainapi/api.dart';
// TODO Configure API key authorization: sigv4Reference
//defaultApiClient.getAuthentication<ApiKeyAuth>('sigv4Reference').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('sigv4Reference').apiKeyPrefix = 'Bearer';

final api = Moralpainapi().getAdminApi();
final String operation = count; // String | The analytic operation to perform on the data.
final int starttime = 1640995200; // int | Minimum possible timestamp of a record in UTC seconds since Unix epoch.
final int endtime = 1647907200; // int | Maximum possible timestamp of a record in UTC seconds since Unix epoch.

try {
    final response = api.getAnalytics(operation, starttime, endtime);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AdminApi->getAnalytics: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **operation** | **String**| The analytic operation to perform on the data. | 
 **starttime** | **int**| Minimum possible timestamp of a record in UTC seconds since Unix epoch. | [optional] 
 **endtime** | **int**| Maximum possible timestamp of a record in UTC seconds since Unix epoch. | [optional] 

### Return type

[**AnalyticsResult**](AnalyticsResult.md)

### Authorization

[sigv4Reference](../README.md#sigv4Reference)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

