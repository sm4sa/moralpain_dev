/*package edu.uva.cs.moralpain.s3;

import com.adobe.testing.s3mock.junit5.S3MockExtension;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.uva.cs.moralpain.utils.S3Helper;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import org.openapitools.client.model.Submission;
import org.openapitools.client.model.AnalyticsResult.OperationEnum;

import software.amazon.awssdk.core.exception.SdkException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.utils.builder.SdkBuilder;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

public class SubmissionAnalyzerTest {
    @RegisterExtension
    static final S3MockExtension S3_MOCK =
            S3MockExtension.builder().silent().withSecureConnection(false).build();
    private final S3Client s3Client = S3_MOCK.createS3ClientV2();

    private static final String BUCKET_NAME = "test-submissions";

    private static final int SUBMISSIONS_COUNT = 5;

    private static final int DEFAULT_TIMESTAMP = 795830400;

    @BeforeAll
    private static void initializeEnvironment() {
        System.setProperty("overrideEndpoint", S3_MOCK.getServiceEndpoint());
        System.setProperty("accessKeyId", "foo");
        System.setProperty("secretAccessKey", "bar");
        System.setProperty("bucket", BUCKET_NAME);
    }

    @BeforeEach
    public void setup() {
        CreateBucketRequest createBucketRequest = CreateBucketRequest.builder()
                .bucket(BUCKET_NAME)
                .build();
        s3Client.createBucket(createBucketRequest);
        uploadTestData();
    }

    private void uploadTestData() {
        ObjectMapper objectMapper = new ObjectMapper();
        for (int i = 0; i < SUBMISSIONS_COUNT; i++) {
            long starttime = DEFAULT_TIMESTAMP + i;
            Submission s = new Submission()
                    .id(Integer.toString(i))
                    .score(i)
                    .addSelectionsItem(Integer.toString(i))
                    .timestamp((int) starttime);
            String key = S3Helper.createPrefix(Instant.ofEpochSecond(starttime)) + "/submission.json";
            try {
                PutObjectRequest putOb = PutObjectRequest.builder()
                        .bucket(BUCKET_NAME)
                        .key(key)
                        .build();
                
                s3Client.putObject(putOb, 
                        RequestBody.fromString(objectMapper.writeValueAsString(s)));
            } catch (JsonProcessingException | SdkException e) {
                assert false;
            }
        }
    }

    @AfterEach
    public void teardown() {
      s3Client.listBuckets().buckets().stream().map(Bucket::name).forEach(bucket ->
              s3Client.deleteObjects(d -> d.bucket(bucket)
                      .delete(Delete.builder().objects(s3Client.listObjectsV2(b -> b.bucket(bucket).build())
                              .contents()
                              .stream()
                              .map(S3Object::key)
                              .map(ObjectIdentifier.builder()::key)
                              .map(SdkBuilder::build)
                              .collect(Collectors.toList()))
                              .build())
                      .build()));
  
      s3Client.listBuckets().buckets().stream()
              .map(Bucket::name)
              .map(DeleteBucketRequest.builder()::bucket)
              .map(SdkBuilder::build)
              .forEach(s3Client::deleteBucket);
    }

    private String toJson(OperationEnum operation, BigDecimal result, boolean error, String errorMsg) {
        String ret = "{\"operation\":";
        ret += "\"" + operation.getValue() + "\",";
        ret += "\"result\":";
        ret += result + ",";
        ret += "\"error\":";
        ret += error + ",";
        ret += "\"errormsg\":";
        if (errorMsg == null) {
            ret += "null}";
        } else {
            ret += "\"" + errorMsg + "\"}";
        }
        return ret;
    }

    @Test
    public void whenHandleRequest_thenBodyIsNotEmpty() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("operation", "count");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertFalse(response == null);
        assertFalse(response.getBody() == null);
        assertFalse(response.getBody().isEmpty());
    }

    @Test
    public void givenNoOperation_whenHandleRequest_thenReturnsBadRequest() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(response.getStatusCode(), 400);
        assertEquals(response.getBody(), "Required operation parameter is missing");
    }
    
    @Test
    public void givenInvalidOperation_whenHandleRequest_thenReturnsBadRequest() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("operation", "7_GRAND_DAD");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(response.getStatusCode(), 400);
        assertEquals(
            response.getBody(),
            "Operation parameter has invalid value. "
                    + "The valid values are: average, count, maximum, minimum."
        );
    }

    @Test
    public void givenCountOperationAndNoStarttimeEndtime_whenHandleRequest_thenAllSubmissionsCounted() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("operation", "count");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.COUNT, new BigDecimal(SUBMISSIONS_COUNT), false, null),
            response.getBody()
        );
    }

    @Test
    public void givenCountOperationAndBigTimeRange_whenHandleRequest_thenAllSubmissionsCounted() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("starttime", "" + (DEFAULT_TIMESTAMP - 5));
        params.put("endtime", "" + (DEFAULT_TIMESTAMP + 5));
        params.put("operation", "count");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.COUNT, new BigDecimal(SUBMISSIONS_COUNT), false, null),
            response.getBody()
        );
    }

    @Test
    public void givenCountOperationAndSmallTimeRange_whenHandleRequest_thenFewSubmissionsCounted() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("starttime", "" + (DEFAULT_TIMESTAMP + 1));
        params.put("endtime", "" + (DEFAULT_TIMESTAMP + 3));
        params.put("operation", "count");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.COUNT, new BigDecimal(3), false, null),
            response.getBody()
        );
    }
    
    @Test
    public void givenCountOperationAndEmptyTimeRange_whenHandleRequest_thenNoSubmissionsCounted() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("starttime", "" + (DEFAULT_TIMESTAMP + 10));
        params.put("endtime", "" + (DEFAULT_TIMESTAMP + 50));
        params.put("operation", "count");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.COUNT, new BigDecimal(0), false, null),
            response.getBody()
        );
    }

    @Test
    public void givenCountOperationAndInvertedTimeRange_whenHandleRequest_thenNoSubmissionsCounted() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("starttime", "" + (DEFAULT_TIMESTAMP + 4));
        params.put("endtime", "" + DEFAULT_TIMESTAMP);
        params.put("operation", "count");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.COUNT, new BigDecimal(0), false, null),
            response.getBody()
        );
    }

    @Test
    public void givenAverageOperationAndNoTimeRange_whenHandleRequest_thenAverageAll() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("operation", "average");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.AVERAGE, new BigDecimal(2), false, null),
            response.getBody()
        );
    }

    @Test
    public void givenAverageOperationAndTinyTimeRange_whenHandleRequest_thenAverageOne() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("starttime", "" + DEFAULT_TIMESTAMP);
        params.put("endtime", "" + DEFAULT_TIMESTAMP);
        params.put("operation", "average");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.AVERAGE, new BigDecimal(0), false, null),
            response.getBody()
        );
    }

    @Test
    public void givenAverageOperationAndEmptyTimeRange_whenHandleRequest_thenReturnErrorMsg() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("starttime", "" + (DEFAULT_TIMESTAMP + 4));
        params.put("endtime", "" + DEFAULT_TIMESTAMP);
        params.put("operation", "average");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        String errorMsg = "There are no submissions in the given timeframe, "
                + "so the average operation cannot be performed.";
        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.AVERAGE, null, true, errorMsg),
            response.getBody()
        );
    }

    @Test
    public void givenMaxOperationAndNoTimeRange_whenHandleRequest_thenReturnMaxOfAll() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("operation", "maximum");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.MAXIMUM, new BigDecimal(SUBMISSIONS_COUNT - 1), false, null),
            response.getBody()
        );
    }

    @Test
    public void givenMaxOperationAndTinyTimeRange_whenHandleRequest_thenReturnMaxOfOne() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("starttime", "" + DEFAULT_TIMESTAMP);
        params.put("endtime", "" + DEFAULT_TIMESTAMP);
        params.put("operation", "maximum");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.MAXIMUM, new BigDecimal(0), false, null),
            response.getBody()
        );
    }

    @Test
    public void givenMaxOperationAndEmptyTimeRange_whenHandleRequest_thenReturnErrorMsg() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("starttime", "" + (DEFAULT_TIMESTAMP + 4));
        params.put("endtime", "" + DEFAULT_TIMESTAMP);
        params.put("operation", "maximum");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        String errorMsg = "There are no submissions in the given timeframe, "
                + "so the maximum operation cannot be performed.";
        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.MAXIMUM, null, true, errorMsg),
            response.getBody()
        );
    }

    @Test
    public void givenMinOperationAndNoTimeRange_whenHandleRequest_thenReturnMinOfAll() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("operation", "minimum");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.MINIMUM, new BigDecimal(0), false, null),
            response.getBody()
        );
    }

    @Test
    public void givenMinOperationAndTinyTimeRange_whenHandleRequest_thenReturnMinOfOne() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("starttime", "" + DEFAULT_TIMESTAMP);
        params.put("endtime", "" + DEFAULT_TIMESTAMP);
        params.put("operation", "minimum");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.MINIMUM, new BigDecimal(0), false, null),
            response.getBody()
        );
    }

    @Test
    public void givenMinOperationAndEmptyTimeRange_whenHandleRequest_thenReturnErrorMsg() {
        SubmissionAnalyzer submissionAnalyzer = new SubmissionAnalyzer();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("starttime", "" + (DEFAULT_TIMESTAMP + 4));
        params.put("endtime", "" + DEFAULT_TIMESTAMP);
        params.put("operation", "minimum");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = submissionAnalyzer.handleRequest(event, new MockContext());

        String errorMsg = "There are no submissions in the given timeframe, "
                + "so the minimum operation cannot be performed.";
        assertEquals(200, response.getStatusCode());
        assertEquals(
            toJson(OperationEnum.MINIMUM, null, true, errorMsg),
            response.getBody()
        );
    }
}
*/