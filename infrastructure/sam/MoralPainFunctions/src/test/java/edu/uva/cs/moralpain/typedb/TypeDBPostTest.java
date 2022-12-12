package edu.uva.cs.moralpain.typedb;

import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import com.vaticle.typedb.client.TypeDB;
import com.vaticle.typedb.client.api.TypeDBClient;
import com.vaticle.typedb.client.api.TypeDBOptions;
import com.vaticle.typedb.client.api.TypeDBSession;
import com.vaticle.typedb.client.api.answer.ConceptMap;
import com.vaticle.typedb.common.test.TypeDBRunner;
import com.vaticle.typeql.lang.TypeQL;
import com.vaticle.typeql.lang.query.TypeQLDefine;
import com.vaticle.typeql.lang.query.TypeQLMatch;
import edu.uva.cs.moralpain.TypeDBHelper;
import edu.uva.cs.moralpain.UtilsForTesting;
import edu.uva.cs.moralpain.s3.MockContext;
import edu.uva.cs.moralpain.utils.VariableManager;
import org.junit.jupiter.api.*;

import java.io.IOException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.concurrent.TimeoutException;
import java.util.stream.Collectors;

import static com.vaticle.typedb.client.api.TypeDBTransaction.Type.READ;
import static com.vaticle.typeql.lang.TypeQL.var;
import static org.junit.jupiter.api.Assertions.assertEquals;


public class TypeDBPostTest {
  // Constants.
  private static final String DB_NAME = "testdb";
  private static final String DB_SCHEMA_FILE = "/report_schema.tql";

  // Class scope.
  private static TypeDBRunner typedb;
  private static TypeDBClient typedbClient;
  private static TypeDBHelper typedbHelper;


  @BeforeAll
  public static void beforeAll() throws IOException, InterruptedException, TimeoutException {
    // Start typedb instance.
    VariableManager runnerConfig = new VariableManager();
    runnerConfig.put("typedb.distribution", "/Users/nickphair/Downloads/typedb-server-mac-2.12.0.zip");
    typedb = new TypeDBTestRunner(runnerConfig);
    typedb.start();

    // Build clients for testing.
    typedbClient = TypeDB.coreClient(typedb.address());
    typedbHelper = new TypeDBHelper(typedbClient, DB_NAME);

    // Set environment for lambda.
    System.setProperty("DATABASE_NAME", DB_NAME);
    System.setProperty("DATABASE_ADDRESS", typedb.address());
  }

  @AfterAll
  public static void afterAll() {
    typedbClient.close();
    typedb.stop();

    System.clearProperty("DATABASE_NAME");
    System.clearProperty("DATABASE_ADDRESS");
  }

  @BeforeEach
  public void beforeEach() throws IOException {
    if (typedbClient.databases().contains(DB_NAME)) {
      typedbClient.databases().get(DB_NAME).delete();
    }
    typedbClient.databases().create(DB_NAME);

    URL url = getClass().getResource(DB_SCHEMA_FILE);
    byte[] encoded = Files.readAllBytes(Paths.get(url.getPath()));
    String schemaString = new String(encoded, StandardCharsets.UTF_8);

    typedbHelper.localhostTypeDBTX(tx -> {
      TypeQLDefine schema = TypeQL.parseQuery(schemaString).asDefine();
      tx.query().define(schema);
      tx.commit();
    }, TypeDBSession.Type.SCHEMA);
  }

  @AfterEach
  public void deleteDatabase() {
    System.out.println("Deleted the " + DB_NAME + " database");
    typedbClient.databases().get(DB_NAME).delete();
    typedbClient.close();
  }


  @Test
  public void testSurveyUpload() {
    TypeDBPost typeDBPost = new TypeDBPost();
    APIGatewayProxyRequestEvent event = new APIGatewayProxyRequestEvent();
    URL url = getClass().getResource("/exampleSurveyResult.json");
    event.setBody(UtilsForTesting.fileToString(url));

    APIGatewayProxyResponseEvent result = typeDBPost.handleRequest(event, new MockContext());
    assertEquals(200, result.getStatusCode());

    typedbHelper.localhostTypeDBTX(tx -> {
      TypeQLMatch.Limited query = TypeQL.match(var("p")
              .isa("report")
              .has("score", var("s")))
              .limit(1);
      ConceptMap answer = tx.query()
              .match(query)
              .collect(Collectors.toList())
              .get(0);

      Long score = answer.get("s").asAttribute().asLong().getValue();
      assertEquals(5, score);
    }, READ, TypeDBOptions.core().prefetch(true).prefetchSize(50));
  }
}
