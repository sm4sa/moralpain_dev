# moralpainapi.api.AdminApi

## Load the API package
```dart
import 'package:moralpainapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAnalytics**](AdminApi.md#getanalytics) | **GET** /admin/analytics | Get data analysis
[**getSubmissions**](AdminApi.md#getsubmissions) | **GET** /admin/submissions | Get survey results


# **getAnalytics**
> Submissions getAnalytics(operation, starttime, endtime)

Get data analysis

Perform an analysis on the records in the database that match the query paramters. 

### Example
```dart
import 'package:moralpainapi/api.dart';

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

[**Submissions**](Submissions.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSubmissions**
> Submissions getSubmissions(starttime, endtime, minscore, maxscore)

Get survey results

Fetch from the database all of the records that match the query parameters. 

### Example
```dart
import 'package:moralpainapi/api.dart';

final api = Moralpainapi().getAdminApi();
final int starttime = 1640995200; // int | Minimum possible timestamp of a record in UTC seconds since Unix epoch.
final int endtime = 1647907200; // int | Maximum possible timestamp of a record in UTC seconds since Unix epoch.
final int minscore = 1; // int | Minimum possible score of a record.
final int maxscore = 5; // int | Maximum possible score of a record.

try {
    final response = api.getSubmissions(starttime, endtime, minscore, maxscore);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AdminApi->getSubmissions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **starttime** | **int**| Minimum possible timestamp of a record in UTC seconds since Unix epoch. | [optional] 
 **endtime** | **int**| Maximum possible timestamp of a record in UTC seconds since Unix epoch. | [optional] 
 **minscore** | **int**| Minimum possible score of a record. | [optional] 
 **maxscore** | **int**| Maximum possible score of a record. | [optional] 

### Return type

[**Submissions**](Submissions.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

