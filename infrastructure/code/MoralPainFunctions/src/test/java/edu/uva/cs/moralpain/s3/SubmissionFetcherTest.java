package edu.uva.cs.moralpain.s3;

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
import org.openapitools.client.model.Submissions;
import software.amazon.awssdk.core.exception.SdkException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.utils.builder.SdkBuilder;

import java.time.Instant;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

public class SubmissionFetcherTest {

  @RegisterExtension
  static final S3MockExtension S3_MOCK =
          S3MockExtension.builder().silent().withSecureConnection(false).build();
  private final S3Client s3Client = S3_MOCK.createS3ClientV2();

  private static final String BUCKET_NAME = "test-submissions";

  private static final int SUBMISSIONS_COUNT = 5;

  private static final int DEFAULT_TIMESTAMP = 795830400;

  private static final Submission[] SUBMISSIONS = new Submission[SUBMISSIONS_COUNT];

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
    for(int i = 0; i < SUBMISSIONS_COUNT; i++) {
      long starttime = DEFAULT_TIMESTAMP + i;
      Submission s = new Submission()
              .id(Integer.toString(i))
              .score(i)
              .addSelectionsItem(Integer.toString(i))
              .timestamp((int) starttime);
      SUBMISSIONS[i] = s;
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

  private String toJson(Submissions submissions) {
    String ret = "{\"list\":[";
    for (int i = 0; i < submissions.getList().size(); i++) {
      Submission s = submissions.getList().get(i);
      ret += toJson(s);
      if (i != submissions.getList().size() - 1) {
        ret += ",";
      }
    }
    ret += "]}";
    return ret;
  }

  private String toJson(Submission submission) {
    String ret = "{\"score\":";
    ret += submission.getScore();
    ret += ",\"selections\":[";
    for (int i = 0; i < submission.getSelections().size(); i++) {
      ret += "\"" + submission.getSelections().get(i) + "\"";
      if (i != submission.getSelections().size() - 1) {
        ret += ",";
      }
    }
    ret += "],\"timestamp\":";
    ret += submission.getTimestamp();
    ret += ",\"id\":\"";
    ret += submission.getId();
    ret += "\"}";
    return ret;
  }

  @Test
  public void whenHandleRequest_thenBodyIsNotEmpty() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    // params.put("starttime", Long.toString(795830401));
    // params.put("endtime", Long.toString(795830403));
    // params.put("minscore", Integer.toString(1));
    // params.put("maxscore", Integer.toString(2));

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse result = submissionFetcher.handleRequest(event, new MockContext());

    assertFalse(result.getBody().isEmpty());
  }

  @Test
  public void givenNoParams_whenHandleRequest_thenAllSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    for (Submission s : SUBMISSIONS) {
      expectedSubmissions.addListItem(s);
    }

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }

  @Test
  public void givenBigTimeRange_whenHandleRequest_thenAllSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("starttime", "" + (DEFAULT_TIMESTAMP - 5));
    params.put("endtime", "" + (DEFAULT_TIMESTAMP + 5));

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    for (Submission s : SUBMISSIONS) {
      expectedSubmissions.addListItem(s);
    }

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }

  @Test
  public void givenSmallTimeRange_whenHandleRequest_thenFewSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("starttime", "" + (DEFAULT_TIMESTAMP + 1));
    params.put("endtime", "" + (DEFAULT_TIMESTAMP + 3));

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    for (int i = 1; i <= 3; i++) {
      expectedSubmissions.addListItem(SUBMISSIONS[i]);
    }

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }

  @Test
  public void givenEmptyTimeRange_whenHandleRequest_thenNoSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("starttime", "" + (DEFAULT_TIMESTAMP + 10));
    params.put("endtime", "" + (DEFAULT_TIMESTAMP + 50));

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    expectedSubmissions.setList(new ArrayList<>());

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }

  @Test
  public void givenInvertedTimeRange_whenHandleRequest_thenNoSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("starttime", "" + (DEFAULT_TIMESTAMP + 4));
    params.put("endtime", "" + DEFAULT_TIMESTAMP);

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    expectedSubmissions.setList(new ArrayList<>());

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }

  @Test
  public void givenBigScoreRange_whenHandleRequest_thenAllSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("minscore", "0");
    params.put("maxscore", "10");

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    for (Submission s : SUBMISSIONS) {
      expectedSubmissions.addListItem(s);
    }

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }

  @Test
  public void givenSmallScoreRange_whenHandleRequest_thenSomeSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("minscore", "1");
    params.put("maxscore", "3");

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    for (int i = 1; i <= 3; i++) {
      expectedSubmissions.addListItem(SUBMISSIONS[i]);
    }

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }

  @Test
  public void givenEmptyScoreRange_whenHandleRequest_thenNoSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("minscore", "6");
    params.put("maxscore", "6");

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    expectedSubmissions.setList(new ArrayList<>());

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }

  @Test
  public void givenInvertedScoreRange_whenHandleRequest_thenNoSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("minscore", "4");
    params.put("maxscore", "0");

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    expectedSubmissions.setList(new ArrayList<>());

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }

  @Test
  public void givenOverlappingTimeRangeAndScoreRange_whenHandleRequest_thenSomeSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("starttime", "" + DEFAULT_TIMESTAMP);
    params.put("endtime", "" + (DEFAULT_TIMESTAMP + 2));
    params.put("minscore", "1");
    params.put("maxscore", "3");

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    for (int i = 1; i <= 2; i++) {
      expectedSubmissions.addListItem(SUBMISSIONS[i]);
    }

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }

  @Test
  public void givenNonOverlappingTimeRangeAndScoreRange_whenHandleRequest_thenNoSubmissionsFetched() {
    SubmissionFetcher submissionFetcher = new SubmissionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("starttime", "" + DEFAULT_TIMESTAMP);
    params.put("endtime", "" + (DEFAULT_TIMESTAMP + 1));
    params.put("minscore", "3");
    params.put("maxscore", "4");

    event.setQueryStringParameters(params);
    APIGatewayV2HTTPResponse response = submissionFetcher.handleRequest(event, new MockContext());

    Submissions expectedSubmissions = new Submissions();
    expectedSubmissions.setList(new ArrayList<>());

    assertEquals(200, response.getStatusCode());
    assertEquals(toJson(expectedSubmissions), response.getBody());
  }
}
