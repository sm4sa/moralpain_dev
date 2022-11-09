package edu.uva.cs.moralpain.typedb;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.ArrayList;

import com.vaticle.typedb.client.TypeDB;
import com.vaticle.typedb.client.api.TypeDBClient;
import com.vaticle.typedb.client.api.TypeDBSession;
import com.vaticle.typedb.client.api.TypeDBTransaction;
import com.vaticle.typedb.client.api.answer.ConceptMap;
import com.vaticle.typeql.lang.TypeQL;
import com.vaticle.typeql.lang.pattern.variable.ThingVariable;
import com.vaticle.typeql.lang.query.TypeQLInsert;
import static com.vaticle.typeql.lang.TypeQL.var;
import java.lang.reflect.TypeVariable;

public class TypeDBPost implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {

    JSONObject obj = new JSONObject();
    List<JSONObject> reports = new ArrayList<JSONObject>();
    JSONParser parser = new JSONParser();

    public APIGatewayProxyResponseEvent handleRequest(final APIGatewayProxyRequestEvent input, final Context context) {
        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("X-Custom-Header", "application/json");

        APIGatewayProxyResponseEvent response = new APIGatewayProxyResponseEvent().withHeaders(headers);

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

            String ip = String.format("%s:1729", System.getenv("EC2_IP_ADDRESS"));
            TypeDBClient client = TypeDB.coreClient(ip);
            // open up a session
            try (TypeDBSession session = client.session(System.getenv("DATABASE_NAME"), TypeDBSession.Type.DATA)) {

                try (TypeDBTransaction writeTransaction = session.transaction(TypeDBTransaction.Type.WRITE)) {

                    // Insert a report using a WRITE transaction
                    var report = var("r").isa("report").has("id", id).has("score", score).has("timestamp",
                            timestamp);

                    for (String selection : selections) {
                        report = report.has("selection", selection);
                    }
                    TypeQLInsert insertQuery = TypeQL.insert(report);

                    List<Object> insertedId = writeTransaction.query().insert(insertQuery).collect(Collectors.toList());
                    System.out.println(
                            "Inserted a person with ID: "
                                    + ((ConceptMap) insertedId.get(0)).get("r").asThing().getIID());

                    // to persist changes, a write transaction must always be committed (closed)
                    writeTransaction.commit();
                }
            }

            return response.withStatusCode(200).withBody(" OK");
        } catch (ParseException e) {
            e.printStackTrace();
            return response.withStatusCode(400).withBody(" error");
        }

    }
}
