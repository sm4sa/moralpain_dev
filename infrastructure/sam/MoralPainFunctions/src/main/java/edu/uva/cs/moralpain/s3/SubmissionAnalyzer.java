package edu.uva.cs.moralpain.s3;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import edu.uva.cs.moralpain.utils.S3Helper;
import edu.uva.cs.moralpain.utils.VariableManager;
import java.time.Instant;
import java.util.Collection;
import java.util.Map;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.S3Object;


import static edu.uva.cs.moralpain.utils.S3Helper.createS3Client;

public class SubmissionAnalyzer implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {
    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent apiGatewayV2HTTPEvent, Context context) {
        return null;
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
                .map(key -> S3Helper.getObjectAsSubmission(client, bucket, key));
        
        return null;
    }

    private boolean isValidEvent(APIGatewayV2HTTPEvent event) {
        return event != null;
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager.containsKey("bucket") && !variableManager.getOrDefault("bucket", "").isEmpty();
    }
}