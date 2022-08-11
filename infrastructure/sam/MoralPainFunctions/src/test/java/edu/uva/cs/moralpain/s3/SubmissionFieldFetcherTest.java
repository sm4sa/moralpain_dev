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
import software.amazon.awssdk.core.exception.SdkException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.utils.builder.SdkBuilder;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class SubmissionFieldFetcherTest {

    @RegisterExtension
    static final S3MockExtension S3_MOCK = S3MockExtension.builder().silent().withSecureConnection(false).build();
    private final S3Client s3Client = S3_MOCK.createS3ClientV2();

    private static final String BUCKET_NAME = "test-submissions";

    private static final String PREFIX_NAME = "surveys/";

    private static final int SUBMISSIONS_COUNT = 5;

    private static final int DEFAULT_TIMESTAMP = 795830400;

    private static final Submission[] SUBMISSIONS = new Submission[SUBMISSIONS_COUNT];

    @BeforeAll
    private static void initializeEnvironment() {
        System.setProperty("overrideEndpoint", S3_MOCK.getServiceEndpoint());
        System.setProperty("accessKeyId", "foo");
        System.setProperty("secretAccessKey", "bar");
        System.setProperty("bucket", BUCKET_NAME);
        System.setProperty("prefix", PREFIX_NAME);
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
            SUBMISSIONS[i] = s;
            String key = PREFIX_NAME + S3Helper.createPrefix(Instant.ofEpochSecond(starttime)) + "/submission.json";
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
        s3Client.listBuckets().buckets().stream().map(Bucket::name)
                .forEach(bucket -> s3Client.deleteObjects(d -> d.bucket(bucket)
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

    @Test
    public void givenNoUuid_whenHandleRequest_thenBadRequestReturned() {
        SubmissionFieldFetcher fetcher = new SubmissionFieldFetcher();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = fetcher.handleRequest(event, new MockContext());

        assertEquals(400, response.getStatusCode());
        assertEquals("Required UUID parameter is missing", response.getBody());
    }

    @Test
    public void givenExistingUuid_whenHandleRequest_thenCorrectTimestampReturned() {
        SubmissionFieldFetcher fetcher = new SubmissionFieldFetcher();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("uuid", "3");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = fetcher.handleRequest(event, new MockContext());

        assertEquals(200, response.getStatusCode());
        assertEquals("" + (DEFAULT_TIMESTAMP + 3), response.getBody());
    }

    @Test
    public void givenNonexistentUuid_whenHandleRequest_thenBadRequestReturned() {
        SubmissionFieldFetcher fetcher = new SubmissionFieldFetcher();

        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("uuid", "6");

        event.setQueryStringParameters(params);
        APIGatewayV2HTTPResponse response = fetcher.handleRequest(event, new MockContext());

        assertEquals(400, response.getStatusCode());
        assertEquals("No submission found with UUID 6", response.getBody());
    }
}
