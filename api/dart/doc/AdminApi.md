# moralpainapi.api.AdminApi

## Load the API package
```dart
import 'package:moralpainapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getSubmissions**](AdminApi.md#getsubmissions) | **GET** /admin/submissions | Get survey results


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

