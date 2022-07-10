package edu.uva.cs.moralpain.s3;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import edu.uva.cs.moralpain.utils.S3Helper;
import edu.uva.cs.moralpain.utils.VariableManager;
import org.openapitools.client.model.Submission;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.S3Object;

import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.time.Instant;

import static edu.uva.cs.moralpain.utils.S3Helper.createS3Client;

public class SubmissionAnalyzer implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {
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
            qs = Collections.emptyMap();
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

        List<Submission> submissions = client.listObjectsV2(listObjectsV2Request).contents()
                .stream()
                .map(S3Object::key)
                .filter(sfpb.beforeOrAtEndTime())
                .map(key -> S3Helper.getObjectAsSubmission(client, bucket, key))
                .collect(Collectors.toList());
        
        String operation = qs.getOrDefault("operation", "");
        
        if (operation.equals("")) {
            response.setBody("Required operation parameter is missing");
            response.setStatusCode(400);
        } else if (!isValidOperation(operation)) {
            response.setBody("Operation parameter has invalid value. "
                    + "The valid values are: average, count, maximum, minimum.");
            response.setStatusCode(400);
        } else if (operation.equals("count")) {
            response.setBody("" + submissions.size());
            response.setStatusCode(200);
        } else {
            Iterator<Submission> iterator = submissions.iterator();

            if (operation.equals("average")) {
                // Return error if there are no submissions!
                if (submissions.size() == 0) {
                    response.setStatusCode(400);
                    response.setBody("There are no submissions in the given timeframe, "
                            + "so the average operation cannot be performed.");
                } else {
                    int sum = 0;
                    while (iterator.hasNext()) {
                        sum += iterator.next().getScore();
                    }
                    double avg = sum/submissions.size();
                    response.setBody("" + avg);
                    response.setStatusCode(200);
                }
            } else if (operation.equals("maximum")) {
                // Return error if there are no submissions!
                if (submissions.size() == 0) {
                    response.setStatusCode(400);
                    response.setBody("There are no submissions in the given timeframe, "
                            + "so the maximum operation cannot be performed.");
                } else {
                    int max = Integer.MIN_VALUE;
                    while (iterator.hasNext()) {
                        int current = iterator.next().getScore();
                        max = current > max ? current : max;
                    }
                    response.setBody("" + max);
                    response.setStatusCode(200);
                }
            } else if (operation.equals("minimum")) {
                // Return error if there are no submissions!
                if (submissions.size() == 0) {
                    response.setStatusCode(400);
                    response.setBody("There are no submissions in the given timeframe, "
                            + "so the minimum operation cannot be performed.");
                } else {
                    int min = Integer.MAX_VALUE;
                    while (iterator.hasNext()) {
                        int current = iterator.next().getScore();
                        min = current < min ? current : min;
                    }
                    response.setBody("" + min);
                    response.setStatusCode(200);
                }
            }
        }

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

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager.containsKey("bucket") && !variableManager.getOrDefault("bucket", "").isEmpty();
    }

    private boolean isValidEvent(APIGatewayV2HTTPEvent event) {
        return event != null;
    }

    private static boolean isValidOperation(String operation) {
        return operation.equals("average")
                || operation.equals("count")
                || operation.equals("maximum")
                || operation.equals("minimum");
    }
}
