# AdminApi

All URIs are relative to *http://localhost*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**getAnalytics**](AdminApi.md#getAnalytics) | **GET** /admin/analytics | Get data analysis |
| [**getSubmissions**](AdminApi.md#getSubmissions) | **GET** /admin/submissions | Get survey results |


<a name="getAnalytics"></a>
# **getAnalytics**
> AnalyticsResult getAnalytics(operation, starttime, endtime)

Get data analysis

Perform an analysis on the records in the database that match the query paramters. 

### Example
```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.AdminApi;

public class Example {
  public static void main(String[] args) {
    ApiClient defaultClient = Configuration.getDefaultApiClient();
    defaultClient.setBasePath("http://localhost");

    AdminApi apiInstance = new AdminApi(defaultClient);
    String operation = "average"; // String | The analytic operation to perform on the data.
    Integer starttime = 1640995200; // Integer | Minimum possible timestamp of a record in UTC seconds since Unix epoch.
    Integer endtime = 1647907200; // Integer | Maximum possible timestamp of a record in UTC seconds since Unix epoch.
    try {
      AnalyticsResult result = apiInstance.getAnalytics(operation, starttime, endtime);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling AdminApi#getAnalytics");
      System.err.println("Status code: " + e.getCode());
      System.err.println("Reason: " + e.getResponseBody());
      System.err.println("Response headers: " + e.getResponseHeaders());
      e.printStackTrace();
    }
  }
}
```

### Parameters

| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **operation** | **String**| The analytic operation to perform on the data. | [enum: average, count, maximum, minimum] |
| **starttime** | **Integer**| Minimum possible timestamp of a record in UTC seconds since Unix epoch. | [optional] |
| **endtime** | **Integer**| Maximum possible timestamp of a record in UTC seconds since Unix epoch. | [optional] |

### Return type

[**AnalyticsResult**](AnalyticsResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | 200 response |  -  |
| **400** | 400 Bad Request |  -  |

<a name="getSubmissions"></a>
# **getSubmissions**
> Submissions getSubmissions(starttime, endtime, minscore, maxscore)

Get survey results

Fetch from the database all of the records that match the query parameters. 

### Example
```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.AdminApi;

public class Example {
  public static void main(String[] args) {
    ApiClient defaultClient = Configuration.getDefaultApiClient();
    defaultClient.setBasePath("http://localhost");

    AdminApi apiInstance = new AdminApi(defaultClient);
    Integer starttime = 1640995200; // Integer | Minimum possible timestamp of a record in UTC seconds since Unix epoch.
    Integer endtime = 1647907200; // Integer | Maximum possible timestamp of a record in UTC seconds since Unix epoch.
    Integer minscore = 1; // Integer | Minimum possible score of a record.
    Integer maxscore = 5; // Integer | Maximum possible score of a record.
    try {
      Submissions result = apiInstance.getSubmissions(starttime, endtime, minscore, maxscore);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling AdminApi#getSubmissions");
      System.err.println("Status code: " + e.getCode());
      System.err.println("Reason: " + e.getResponseBody());
      System.err.println("Response headers: " + e.getResponseHeaders());
      e.printStackTrace();
    }
  }
}
```

### Parameters

| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **starttime** | **Integer**| Minimum possible timestamp of a record in UTC seconds since Unix epoch. | [optional] |
| **endtime** | **Integer**| Maximum possible timestamp of a record in UTC seconds since Unix epoch. | [optional] |
| **minscore** | **Integer**| Minimum possible score of a record. | [optional] |
| **maxscore** | **Integer**| Maximum possible score of a record. | [optional] |

### Return type

[**Submissions**](Submissions.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | 200 response |  * Access-Control-Allow-Origin -  <br>  * Access-Control-Allow-Methods -  <br>  * Access-Control-Allow-Headers -  <br>  |

