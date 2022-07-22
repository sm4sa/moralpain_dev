package edu.uva.cs.moralpain.s3;

import com.adobe.testing.s3mock.junit5.S3MockExtension;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import edu.uva.cs.moralpain.UtilsForTesting;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.utils.builder.SdkBuilder;

import java.net.URL;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

public class UniqueKeyUploaderTest {

  @RegisterExtension
  static final S3MockExtension S3_MOCK =
          S3MockExtension.builder().silent().withSecureConnection(false).build();
  private final S3Client s3Client = S3_MOCK.createS3ClientV2();

  private static final String BUCKET_NAME = "test-submissions";

  @BeforeEach
  public void setup() {
    CreateBucketRequest createBucketRequest = CreateBucketRequest.builder()
            .bucket(BUCKET_NAME)
            .build();
    s3Client.createBucket(createBucketRequest);
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

  @Test
  public void testSurveyUploadedToS3() {
    initializeEnvironment();
    UniqueKeyUploader uniqueKeyUploader = new UniqueKeyUploader();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    URL url = getClass().getResource("/exampleSurveyResult.json");
    event.setBody(UtilsForTesting.fileToString(url));
    APIGatewayV2HTTPResponse result01 = uniqueKeyUploader.handleRequest(event, new MockContext());
    APIGatewayV2HTTPResponse result02 = uniqueKeyUploader.handleRequest(event, new MockContext());

    assertEquals(2, s3Client.listObjectsV2(b -> b.bucket(BUCKET_NAME).build()).keyCount());
    assertNotEquals(500, result01.getStatusCode());
    assertNotEquals(500, result02.getStatusCode());
  }

  @Test
  public void testSurveyUploadedToS3WithPrefix() {
    initializeEnvironment();
    System.setProperty("prefix", "foo");
    UniqueKeyUploader uniqueKeyUploader = new UniqueKeyUploader();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    URL url = getClass().getResource("/exampleSurveyResult.json");
    event.setBody(UtilsForTesting.fileToString(url));
    uniqueKeyUploader.handleRequest(event, new MockContext());

    assertTrue(s3Client.listObjects((req) -> req.bucket(BUCKET_NAME).build()).contents().get(0).key().contains("foo"));
  }

  @BeforeEach
  private void initializeEnvironment() {
    System.setProperty("overrideEndpoint", S3_MOCK.getServiceEndpoint());
    System.setProperty("accessKeyId", "foo");
    System.setProperty("secretAccessKey", "bar");
    System.setProperty("bucket", BUCKET_NAME);
  }

}
