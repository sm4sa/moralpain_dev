package edu.uva.cs.moralpain;

import com.fasterxml.jackson.databind.ObjectMapper;
import edu.uva.cs.moralpain.models.SurveyResult;
import org.junit.Test;

import java.io.IOException;
import java.net.URL;

import static org.junit.Assert.*;

/**
 * Simple Tests to make sure the SurveyResult model aligns with the data.
 */
public class TestSurveyResult {

  @Test
  public void testMapping() throws IOException {
    ObjectMapper objectMapper = new ObjectMapper();

    URL url = getClass().getResource("/exampleSurveyResult.json");
    SurveyResult result = objectMapper.readValue(url, SurveyResult.class);

    assertEquals(5, result.getScore());
    assertEquals(1609459200, result.getTimestamp());
    assertEquals("foobar", result.getId());
    assertArrayEquals(new Object[]{"001_01", "002_02", "003_03"}, result.getSelections().toArray());
  }


}
