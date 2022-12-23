# UserApi

All URIs are relative to *http://localhost*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**getResiliencyResources**](UserApi.md#getResiliencyResources) | **GET** /resiliency | Get resiliency resources |
| [**getSubmission**](UserApi.md#getSubmission) | **GET** /submission | get the submission |
| [**getSubmissions**](UserApi.md#getSubmissions) | **GET** /submissions | get the submissions |
| [**getSurvey**](UserApi.md#getSurvey) | **GET** /survey | Get the MDQ |
| [**submitSubmission**](UserApi.md#submitSubmission) | **POST** /submission | Submit a submission |
| [**submitSubmissionTypeDB**](UserApi.md#submitSubmissionTypeDB) | **POST** /submissions | Submit a submission |
| [**submitSurvey**](UserApi.md#submitSurvey) | **POST** /survey | Submit a completed MDQ |
| [**submitVisitedResiliencyResources**](UserApi.md#submitVisitedResiliencyResources) | **POST** /resiliency | Submit visited resiliency resources |



## getResiliencyResources

> ResiliencyResources getResiliencyResources()

Get resiliency resources

Fetch the recommended resiliency resources from the database. 

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.UserApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost");

        UserApi apiInstance = new UserApi(defaultClient);
        try {
            ResiliencyResources result = apiInstance.getResiliencyResources();
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling UserApi#getResiliencyResources");
            System.err.println("Status code: " + e.getCode());
            System.err.println("Reason: " + e.getResponseBody());
            System.err.println("Response headers: " + e.getResponseHeaders());
            e.printStackTrace();
        }
    }
}
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**ResiliencyResources**](ResiliencyResources.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | 200 response |  * Access-Control-Allow-Origin -  <br>  * Access-Control-Allow-Methods -  <br>  * Access-Control-Allow-Headers -  <br>  |


## getSubmission

> Submission getSubmission()

get the submission

Get the MDQ submission. 

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.UserApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost");

        UserApi apiInstance = new UserApi(defaultClient);
        try {
            Submission result = apiInstance.getSubmission();
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling UserApi#getSubmission");
            System.err.println("Status code: " + e.getCode());
            System.err.println("Reason: " + e.getResponseBody());
            System.err.println("Response headers: " + e.getResponseHeaders());
            e.printStackTrace();
        }
    }
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


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | 200 response |  * Access-Control-Allow-Origin -  <br>  * Access-Control-Allow-Methods -  <br>  * Access-Control-Allow-Headers -  <br>  |


## getSubmissions

> Submissions getSubmissions()

get the submissions

Get the MDQ submissions using TypeDB. 

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.UserApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost");

        UserApi apiInstance = new UserApi(defaultClient);
        try {
            Submissions result = apiInstance.getSubmissions();
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling UserApi#getSubmissions");
            System.err.println("Status code: " + e.getCode());
            System.err.println("Reason: " + e.getResponseBody());
            System.err.println("Response headers: " + e.getResponseHeaders());
            e.printStackTrace();
        }
    }
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


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | 200 response |  * Access-Control-Allow-Origin -  <br>  * Access-Control-Allow-Methods -  <br>  * Access-Control-Allow-Headers -  <br>  |


## getSurvey

> Survey getSurvey()

Get the MDQ

Fetch the latest moral distress questionnaire (MDQ) from the database. 

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.UserApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost");

        UserApi apiInstance = new UserApi(defaultClient);
        try {
            Survey result = apiInstance.getSurvey();
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling UserApi#getSurvey");
            System.err.println("Status code: " + e.getCode());
            System.err.println("Reason: " + e.getResponseBody());
            System.err.println("Response headers: " + e.getResponseHeaders());
            e.printStackTrace();
        }
    }
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


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | 200 response |  * Access-Control-Allow-Origin -  <br>  * Access-Control-Allow-Methods -  <br>  * Access-Control-Allow-Headers -  <br>  |


## submitSubmission

> String submitSubmission(submission)

Submit a submission

Submit 

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.UserApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost");

        UserApi apiInstance = new UserApi(defaultClient);
        Submission submission = new Submission(); // Submission | 
        try {
            String result = apiInstance.submitSubmission(submission);
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling UserApi#submitSubmission");
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
| **submission** | [**Submission**](Submission.md)|  | [optional] |

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: text/plain


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | 200 response |  * Access-Control-Allow-Origin -  <br>  * Access-Control-Allow-Methods -  <br>  * Access-Control-Allow-Headers -  <br>  |


## submitSubmissionTypeDB

> String submitSubmissionTypeDB(submission)

Submit a submission

Submit with TypeDB 

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.UserApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost");

        UserApi apiInstance = new UserApi(defaultClient);
        Submission submission = new Submission(); // Submission | 
        try {
            String result = apiInstance.submitSubmissionTypeDB(submission);
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling UserApi#submitSubmissionTypeDB");
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
| **submission** | [**Submission**](Submission.md)|  | [optional] |

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: text/plain


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | 200 response |  * Access-Control-Allow-Origin -  <br>  * Access-Control-Allow-Methods -  <br>  * Access-Control-Allow-Headers -  <br>  |


## submitSurvey

> String submitSurvey(submission)

Submit a completed MDQ

Submit a completed Moral Distress Questionnaire and Moral Distress Score to the database. 

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.UserApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost");

        UserApi apiInstance = new UserApi(defaultClient);
        Submission submission = new Submission(); // Submission | 
        try {
            String result = apiInstance.submitSurvey(submission);
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling UserApi#submitSurvey");
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
| **submission** | [**Submission**](Submission.md)|  | [optional] |

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: text/plain


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | 200 response |  * Access-Control-Allow-Origin -  <br>  * Access-Control-Allow-Methods -  <br>  * Access-Control-Allow-Headers -  <br>  |


## submitVisitedResiliencyResources

> String submitVisitedResiliencyResources(visitedResiliencyResources)

Submit visited resiliency resources

Submit the list of resources visited by this user to the database. 

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.UserApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("http://localhost");

        UserApi apiInstance = new UserApi(defaultClient);
        VisitedResiliencyResources visitedResiliencyResources = new VisitedResiliencyResources(); // VisitedResiliencyResources | 
        try {
            String result = apiInstance.submitVisitedResiliencyResources(visitedResiliencyResources);
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling UserApi#submitVisitedResiliencyResources");
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
| **visitedResiliencyResources** | [**VisitedResiliencyResources**](VisitedResiliencyResources.md)|  | [optional] |

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: text/plain


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | 200 response |  * Access-Control-Allow-Origin -  <br>  * Access-Control-Allow-Methods -  <br>  * Access-Control-Allow-Headers -  <br>  |

