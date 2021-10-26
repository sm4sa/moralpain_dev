package edu.uva.cs.moralpain;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.AwsCredentials;
import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.exception.SdkServiceException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3ClientBuilder;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.utils.AttributeMap;

import java.net.URI;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import static software.amazon.awssdk.http.SdkHttpConfigurationOption.TRUST_ALL_CERTIFICATES;

/**
 * Handler for requests to Lambda function.
 */
public class App implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent apiGatewayV2HTTPEvent, Context context) {
        APIGatewayV2HTTPResponse response = new APIGatewayV2HTTPResponse();
        if(!isValidEvent(apiGatewayV2HTTPEvent)) {
            context.getLogger().log("invalid event");
            response.setStatusCode(500);
            return response;
        }

        VariableManager variableManager = new VariableManager();
        if(!isValidEnvironment(variableManager)) {
            context.getLogger().log("invalid environment");
            response.setStatusCode(500);
            return response;
        }
        String bucket = variableManager.get("bucket");

        S3Client client = createS3Client(variableManager);
        try {
            client.putObject(PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(createKey())
                    .build(), RequestBody.fromString(apiGatewayV2HTTPEvent.getBody()));
            response.setStatusCode(200);
        } catch(SdkServiceException exception) {
            context.getLogger().log(exception.getMessage());
            response.setStatusCode(500);
            return response;
        }

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("X-Custom-Header", "application/json");
        response.setHeaders(headers);

        return response;
    }


    private boolean isValidEvent(APIGatewayV2HTTPEvent event) {
        return !(event == null || event.getBody() == null || event.getBody().isEmpty());
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager.containsKey("bucket") && !variableManager.getOrDefault("bucket", "").isEmpty();
    }

    /**
     * Create a key that is composed of the current time and a uuid.
     * @return the key
     */
    public static String createKey() {
        Instant now = Instant.now();
        DateTimeFormatter formatter = DateTimeFormatter
                .ofPattern("y/MM/dd/HH/mm/ss")
                .withZone(ZoneId.from(ZoneOffset.UTC));
        String uuid = UUID.randomUUID().toString().replace("-", "");
        return formatter.format(now) + "/" + uuid + ".json";
    }


    /**
     * An S3 Client parameterized by the environment.
     * @param variableManager
     * @return
     */
    public S3Client createS3Client(VariableManager variableManager) {
        String region = variableManager.getOrDefault("region", "us-east-1");

        // TODO (nphair): Do not blindly trust everything. Figure out how to trust only our mocked endpoint.
        S3ClientBuilder builder = S3Client.builder()
                .region(Region.of(region))
                .httpClient(UrlConnectionHttpClient.builder().buildWithDefaults(AttributeMap.builder()
                        .put(TRUST_ALL_CERTIFICATES, Boolean.TRUE)
                        .build()));

        if(variableManager.containsKey("overrideEndpoint")) {
            builder.endpointOverride(URI.create(variableManager.get("overrideEndpoint")));
        }

        if(variableManager.containsKey("accessKeyId") && variableManager.containsKey("secretAccessKey"))  {
            String accessKeyId = variableManager.get("accessKeyId");
            String secretAccessKey = variableManager.get("secretAccessKey");
            AwsCredentials credentials = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
            builder.credentialsProvider(StaticCredentialsProvider.create(credentials));
        }

        return builder.build();
    }


}
