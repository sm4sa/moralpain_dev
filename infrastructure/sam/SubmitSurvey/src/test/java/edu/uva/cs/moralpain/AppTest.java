package edu.uva.cs.moralpain;

import com.adobe.testing.s3mock.junit4.S3MockRule;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.ObjectListing;
import org.junit.After;
import org.junit.Before;
import org.junit.ClassRule;
import org.junit.Test;

import java.net.URL;
import java.util.List;
import java.util.regex.Pattern;

import static org.junit.Assert.*;

public class AppTest {

  @ClassRule
  public static final S3MockRule S3_MOCK_RULE = S3MockRule.builder().silent().build();

  private static final String BUCKET_NAME = "test-submissions";

  private final AmazonS3 s3Client = S3_MOCK_RULE.createS3Client();

  @Before
  public void setup() {
    s3Client.createBucket(BUCKET_NAME);
  }

  @After
  public void teardown() {
    s3Client.listBuckets().stream()
            .map(Bucket::getName)
            .map(s3Client::listObjects)
            .map(ObjectListing::getObjectSummaries)
            .flatMap(List::stream)
            .forEach(obj -> s3Client.deleteObject(obj.getBucketName(), obj.getKey()));
    s3Client.listBuckets().stream()
            .map(Bucket::getName)
            .forEach(s3Client::deleteBucket);
  }

  @Test
  public void testKey() {
    System.out.println(App.createKey());
    String pattern = "\\d{4}/\\d{2}/\\d{2}/\\d{2}/\\d{2}/\\d{2}/\\w{32}\\.json";
    assertTrue(Pattern.matches(pattern, App.createKey()));
  }

  @Test
  public void testSurveyUploadedToS3() {
    initializeEnvironment();
    App app = new App();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    URL url = getClass().getResource("/exampleSurveyResult.json");
    event.setBody(TestUtils.fileToString(url));
    APIGatewayV2HTTPResponse result01 = app.handleRequest(event, new MockContext());
    APIGatewayV2HTTPResponse result02 = app.handleRequest(event, new MockContext());

    assertEquals(2, s3Client.listObjects(BUCKET_NAME).getObjectSummaries().size());
    assertNotEquals(500, result01.getStatusCode());
    assertNotEquals(500, result02.getStatusCode());
  }

  private void initializeEnvironment() {
    System.setProperty("overrideEndpoint", S3_MOCK_RULE.getServiceEndpoint());
    System.setProperty("accessKeyId", "foo");
    System.setProperty("secretAccessKey", "bar");
    System.setProperty("bucket", BUCKET_NAME);
  }

}
