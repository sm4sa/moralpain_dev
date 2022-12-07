package edu.uva.cs.moralpain.typedb;

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
import java.util.ArrayList;

import com.vaticle.typedb.client.TypeDB;
import com.vaticle.typedb.client.api.TypeDBClient;
import com.vaticle.typedb.client.api.TypeDBSession;
import com.vaticle.typedb.client.api.TypeDBTransaction;
import com.vaticle.typedb.client.api.answer.ConceptMap;
import com.vaticle.typeql.lang.TypeQL;
import com.vaticle.typeql.lang.query.TypeQLInsert;
import static com.vaticle.typeql.lang.TypeQL.var;

public class TypeDBPost implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {

    JSONObject obj = new JSONObject();
    List<JSONObject> reports = new ArrayList<JSONObject>();
    JSONParser parser = new JSONParser();

    public APIGatewayProxyResponseEvent handleRequest(final APIGatewayProxyRequestEvent input, final Context context) {
        Map<String, String> headers = new HashMap<>();

        // headers.put("Content-Type", "application/json");
        // headers.put("X-Custom-Header", "application/json");

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

        try {
            JSONObject jsonBodyObject = (JSONObject) parser.parse(body);
            String id = (String) jsonBodyObject.get("id");
            @SuppressWarnings("unchecked")
            List<String> selections = (List<String>) jsonBodyObject.get("selections");
            Long score_long = (Long) jsonBodyObject.get("score");
            int score = score_long.intValue();
            // date comes in as UNIX time in seconds, so we can use int. If it came in
            // miliseconds, use long.
            Long timestamp = (Long) jsonBodyObject.get("timestamp");

            String ip = String.format("%s:1729", variableManager.get("EC2_IP_ADDRESS"));
            try (TypeDBClient client = TypeDB.coreClient(ip)) {

                // open up a session
                try (TypeDBSession session = client.session(variableManager.get("DATABASE_NAME"),
                        TypeDBSession.Type.DATA)) {

                    try (TypeDBTransaction writeTransaction = session.transaction(TypeDBTransaction.Type.WRITE)) {

                        // Insert a report using a WRITE transaction
                        var report = var("r").isa("report").has("id", id).has("score", score).has("timestamp",
                                timestamp);

                        for (String selection : selections) {
                            report = report.has("selection", selection);
                        }
                        TypeQLInsert insertQuery = TypeQL.insert(report);

                        List<Object> insertedId = writeTransaction.query().insert(insertQuery)
                                .collect(Collectors.toList());
                        System.out.println(
                                "Inserted a person with ID: "
                                        + ((ConceptMap) insertedId.get(0)).get("r").asThing().getIID());

                        // to persist changes, a write transaction must always be committed (closed)
                        writeTransaction.commit();
                    } catch (Exception e) {
                        e.printStackTrace();
                        return response.withStatusCode(400).withBody(e.getMessage());
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    return response.withStatusCode(400).withBody(e.getMessage());
                }
            } catch (Exception e) {
                e.printStackTrace();
                return response.withStatusCode(400).withBody(e.getMessage());
            }
            body = "";
            return response.withStatusCode(200).withBody(" OK");
        } catch (ParseException e) {
            e.printStackTrace();
            return response.withStatusCode(400).withBody(" error");
        }

    }

    private boolean isValidEvent(APIGatewayProxyRequestEvent event) {
        return !(event == null || event.getBody() == null || event.getBody().isEmpty());
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager.containsKey("EC2_IP_ADDRESS")
                && !variableManager.getOrDefault("EC2_IP_ADDRESS", "").isEmpty();
    }
}
