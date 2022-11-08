package edu.uva.cs.moralpain.typedb;

import org.json.simple.JSONObject;

import static com.vaticle.typeql.lang.TypeQL.var;

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.stream.Stream;
import java.util.ArrayList;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;

import com.google.gson.Gson;
import com.vaticle.typedb.client.TypeDB;
import com.vaticle.typedb.client.api.TypeDBClient;
import com.vaticle.typedb.client.api.TypeDBSession;
import com.vaticle.typedb.client.api.TypeDBTransaction;
import com.vaticle.typedb.client.api.answer.ConceptMap;
import com.vaticle.typeql.lang.TypeQL;
import com.vaticle.typedb.client.api.TypeDBOptions;
import com.vaticle.typeql.lang.query.*;

/**
 * Handler for requests to Lambda function.
 */
public class TypeDBGet implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {

    JSONObject obj = new JSONObject();
    List<JSONObject> reports = new ArrayList<JSONObject>();

    public APIGatewayProxyResponseEvent handleRequest(final APIGatewayProxyRequestEvent input, final Context context) {
        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("X-Custom-Header", "application/json");

        APIGatewayProxyResponseEvent response = new APIGatewayProxyResponseEvent().withHeaders(headers);
        reports.clear();

        TypeDBClient client = TypeDB.coreClient("192.168.142.245:1729");

        // open up a session
        try (TypeDBSession session = client.session("test", TypeDBSession.Type.DATA)) {
            TypeDBOptions options = TypeDBOptions.core().infer(true); // enable reasoning
            try (TypeDBTransaction readTransaction = session.transaction(TypeDBTransaction.Type.READ, options)) {

                // TypeQLMatch.Filtered getQuery = TypeQL
                // .match(var("r").isa("report").has("selection", var("selections")).has("id",
                // var("id"))
                // .has("score", var("s")).has("timestamp",
                // var("ts")))
                // .get("r", "s", "ts", "id", "selections");
                // Read the person using a READ only transaction
                TypeQLMatch.Filtered getQuery = TypeQL
                        .match(var("r").isa("report").has("id", var("id")).has("score", var("s")).has("timestamp",
                                var("ts")))
                        .get("r", "s", "ts", "id");

                Stream<ConceptMap> answers = readTransaction.query().match(getQuery);

                answers.forEach(answer -> {
                    obj = new JSONObject();
                    // System.out.println(answer.get("r").asThing().getIID());
                    System.out.println("id: " + answer.get("id").asAttribute().getValue());
                    System.out.println("Score: " + answer.get("s").asAttribute().getValue());
                    System.out.println("Timestamp: " + answer.get("ts").asAttribute().getValue());

                    obj.put("timestamp", answer.get("ts").asAttribute().getValue());
                    obj.put("id", answer.get("id").asAttribute().getValue());
                    obj.put("score", answer.get("s").asAttribute().getValue());
                    // obj.put("selections", answer.get("selections").asAttribute().getValue());

                    reports.add(obj);

                });
                System.out.println("reports: " + reports);
            }
        }
        String json = new Gson().toJson(reports);
        // session is closed
        client.close();
        // client is closed
        return response.withStatusCode(200).withBody(json);
    }
}
