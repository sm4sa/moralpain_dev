package edu.uva.cs.moralpain.s3;

import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

public class SubmissionFetcherPredicateBuilderTest {


  @Test
  public void testBeforeOrAtEndTime() {
    Map<String, String> params = new HashMap<>();
    params.put("endtime", Long.toString(1225789202));

    List<String> keys = new ArrayList<>();
    keys.add("2008/11/04/09/00/00/submissions.json");
    keys.add("2008/11/04/09/00/01/submissions.json");
    keys.add("2008/11/04/09/00/02/submissions.json");
    keys.add("2008/11/04/09/00/03/submissions.json");

    SubmissionFetcherPredicateBuilder predicateBuilder = new SubmissionFetcherPredicateBuilder(params);
    assertEquals(3, keys.stream().filter(predicateBuilder.beforeOrAtEndTime()).count());
  }

  @Test
  public void testLessThanOrEqualToMaxScore() {
    Map<String, String> params = new HashMap<>();
    params.put("maxscore", Integer.toString(5));

    List<Integer> scores = new ArrayList<>();
    scores.add(3);
    scores.add(4);
    scores.add(5);
    scores.add(6);

    SubmissionFetcherPredicateBuilder predicateBuilder = new SubmissionFetcherPredicateBuilder(params);
    List<Integer> actual = scores.stream()
            .filter(predicateBuilder.lessThanOrEqualToMaxScore())
            .collect(Collectors.toList());

    assertTrue(actual.contains(3));
    assertTrue(actual.contains(4));
    assertTrue(actual.contains(5));
    assertFalse(actual.contains(6));
  }

  @Test
  public void testGreaterThanOrEqualToMinScore() {
    Map<String, String> params = new HashMap<>();
    params.put("minscore", Integer.toString(5));

    List<Integer> scores = new ArrayList<>();
    scores.add(3);
    scores.add(4);
    scores.add(5);
    scores.add(6);

    SubmissionFetcherPredicateBuilder predicateBuilder = new SubmissionFetcherPredicateBuilder(params);
    List<Integer> actual = scores.stream()
            .filter(predicateBuilder.greaterThanOrEqualToMinScore())
            .collect(Collectors.toList());

    assertFalse(actual.contains(3));
    assertFalse(actual.contains(4));
    assertTrue(actual.contains(5));
    assertTrue(actual.contains(6));
  }

  @Test
  public void testInScoreRange() {
    Map<String, String> params = new HashMap<>();
    params.put("minscore", Integer.toString(4));
    params.put("maxscore", Integer.toString(5));

    List<Integer> scores = new ArrayList<>();
    scores.add(3);
    scores.add(4);
    scores.add(5);
    scores.add(6);

    SubmissionFetcherPredicateBuilder predicateBuilder = new SubmissionFetcherPredicateBuilder(params);
    List<Integer> actual = scores.stream()
            .filter(predicateBuilder.inScoreRange())
            .collect(Collectors.toList());

    assertFalse(actual.contains(3));
    assertTrue(actual.contains(4));
    assertTrue(actual.contains(5));
    assertFalse(actual.contains(6));
  }

}
