package edu.uva.cs.moralpain.typedb;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.openapitools.client.model.Submission;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import edu.uva.cs.moralpain.utils.VariableManager;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.stream.Collectors;
import java.io.IOException;
import java.util.ArrayList;

import com.vaticle.typedb.client.TypeDB;
import com.vaticle.typedb.client.api.TypeDBClient;
import com.vaticle.typedb.client.api.TypeDBSession;
import com.vaticle.typedb.client.api.TypeDBTransaction;
import com.vaticle.typedb.client.api.answer.ConceptMap;
import com.vaticle.typeql.lang.TypeQL;
import com.vaticle.typeql.lang.query.TypeQLInsert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static com.vaticle.typeql.lang.TypeQL.var;

public class TypeDBPost implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {
    private static Logger logger = LoggerFactory.getLogger(TypeDBPost.class);

    JSONObject obj = new JSONObject();
    List<JSONObject> reports = new ArrayList<JSONObject>();
    JSONParser parser = new JSONParser();

    public APIGatewayProxyResponseEvent handleRequest(final APIGatewayProxyRequestEvent input, final Context context) {
        Map<String, String> headers = new HashMap<>();
        APIGatewayProxyResponseEvent response = new APIGatewayProxyResponseEvent().withHeaders(headers);

        if (!isValidEvent(input)) {
            context.getLogger().log("invalid event");
            response.setStatusCode(500);
            return response;
        }

        VariableManager variableManager = new VariableManager();
        if (!isValidEnvironment(variableManager)) {
            context.getLogger().log("invalid environment");
            response.setStatusCode(500);
            return response;
        }

        String body = input.getBody();

        Submission submission;
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            submission = objectMapper.readValue(body, Submission.class);
        } catch (JsonProcessingException e) {
            logger.error(String.format("failed to parse: %s", body), e);
            return response.withStatusCode(400);
        }

        String id = submission.getId();
        List<String> selections = submission.getSelections();
        Integer score = submission.getScore();
        Integer timestamp = submission.getTimestamp();

        String dbAddress = variableManager.get("DATABASE_ADDRESS");
        String dbName = variableManager.get("DATABASE_NAME");

        try (TypeDBClient client = TypeDB.coreClient(dbAddress)) {
            try (TypeDBSession session = client.session(dbName, TypeDBSession.Type.DATA)) {
                try (TypeDBTransaction writeTransaction = session.transaction(TypeDBTransaction.Type.WRITE)) {

                    // Insert a report using a WRITE transaction
                    var report = var("r")
                            .isa("report")
                            .has("id", id)
                            .has("score", score)
                            .has("timestamp", timestamp);

                    for (String selection : selections) {
                        report = report.has("selection", selection);
                    }
                    TypeQLInsert insertQuery = TypeQL.insert(report);

                    List<Object> insertedId = writeTransaction
                            .query()
                            .insert(insertQuery)
                            .collect(Collectors.toList());

                    logger.info("Inserted a person with ID: "
                                    + ((ConceptMap) insertedId.get(0)).get("r").asThing().getIID());

                    // to persist changes, a write transaction must always be committed (closed)
                    writeTransaction.commit();
                } catch (Exception e) {
                    logger.error(e.getMessage());
                    return response.withStatusCode(400);
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
                return response.withStatusCode(400);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return response.withStatusCode(400);
        }

        return response.withStatusCode(200);
    }

    private boolean isValidEvent(APIGatewayProxyRequestEvent event) {
        return !(event == null || event.getBody() == null || event.getBody().isEmpty());
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return !variableManager.getOrDefault("DATABASE_ADDRESS", "").isEmpty() &&
                !variableManager.getOrDefault("DATABASE_NAME", "").isEmpty();
    }
}
