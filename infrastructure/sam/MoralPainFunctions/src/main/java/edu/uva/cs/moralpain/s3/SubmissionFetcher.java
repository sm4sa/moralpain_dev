package edu.uva.cs.moralpain.s3;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.uva.cs.moralpain.utils.S3Helper;
import edu.uva.cs.moralpain.utils.VariableManager;
import org.openapitools.client.model.Submission;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.S3Object;

import java.time.Instant;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import static edu.uva.cs.moralpain.utils.S3Helper.createS3Client;

/**
 * Get submissions that match query
 *
 */
public class SubmissionFetcher implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

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
        String prefix = variableManager.getOrDefault("prefix", "");

        Map<String, String> qs = apiGatewayV2HTTPEvent.getQueryStringParameters();
        if(qs == null) {
            qs = Collections.EMPTY_MAP;
        }
        SubmissionFetcherPredicateBuilder sfpb = new SubmissionFetcherPredicateBuilder(qs);
        String start = qs.getOrDefault("starttime", "");

        S3Client client = createS3Client(variableManager);
        ListObjectsV2Request.Builder builder = ListObjectsV2Request.builder()
                .bucket(bucket)
                .prefix(prefix);
        if(!start.isEmpty()) {
            Instant instant = Instant.ofEpochSecond(Long.parseLong(start));
            String startKey = S3Helper.createPrefix(instant);
            builder.startAfter(startKey);
        }
        ListObjectsV2Request listObjectsV2Request = builder.build();

        Collection submissions = client.listObjectsV2(listObjectsV2Request).contents().stream()
                .map(S3Object::key)
                .filter(sfpb.beforeOrAtEndTime())
                .map(key -> S3Helper.getObjectAsSubmission(client, bucket, key))
                .filter(sfpb.inScoreRange())
                .map(this::toJson)
                .filter(((Predicate<String>) String::isEmpty).negate())
                .collect(Collectors.toList());
        String data = toJson(submissions);
        response.setBody(data);
        response.setStatusCode(200);

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("X-Custom-Header", "application/json");
        // Cors. 
        headers.put("Access-Control-Allow-Headers", "Content-Type,X-Amz-Date,Authorization,X-Api-Key");
        headers.put("Access-Control-Allow-Origin", "*");
        headers.put("Access-Control-Allow-Methods", "*");
        response.setHeaders(headers);

        return response;
    }

    private String toJson(Object value) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(value);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return "";
    }

    private boolean isValidEvent(APIGatewayV2HTTPEvent event) {
        return event != null;
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager.containsKey("bucket") && !variableManager.getOrDefault("bucket", "").isEmpty();
    }
}
