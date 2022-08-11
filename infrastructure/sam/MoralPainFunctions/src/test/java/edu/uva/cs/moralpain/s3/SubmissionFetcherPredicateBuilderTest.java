package edu.uva.cs.moralpain.s3;

import org.junit.jupiter.api.Test;
import org.openapitools.client.model.Submission;

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

    List<Submission> scores = new ArrayList<>();
    scores.add(new Submission().score(3));
    scores.add(new Submission().score(4));
    scores.add(new Submission().score(5));
    scores.add(new Submission().score(6));

    SubmissionFetcherPredicateBuilder predicateBuilder = new SubmissionFetcherPredicateBuilder(params);
    List<Integer> actual = scores.stream()
            .filter(predicateBuilder.lessThanOrEqualToMaxScore())
            .map(Submission::getScore)
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

    List<Submission> scores = new ArrayList<>();
    scores.add(new Submission().score(3));
    scores.add(new Submission().score(4));
    scores.add(new Submission().score(5));
    scores.add(new Submission().score(6));

    SubmissionFetcherPredicateBuilder predicateBuilder = new SubmissionFetcherPredicateBuilder(params);
    List<Integer> actual = scores.stream()
            .filter(predicateBuilder.greaterThanOrEqualToMinScore())
            .map(Submission::getScore)
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

    List<Submission> scores = new ArrayList<>();
    scores.add(new Submission().score(3));
    scores.add(new Submission().score(4));
    scores.add(new Submission().score(5));
    scores.add(new Submission().score(6));

    SubmissionFetcherPredicateBuilder predicateBuilder = new SubmissionFetcherPredicateBuilder(params);
    List<Integer> actual = scores.stream()
            .filter(predicateBuilder.inScoreRange())
            .map(Submission::getScore)
            .collect(Collectors.toList());

    assertFalse(actual.contains(3));
    assertTrue(actual.contains(4));
    assertTrue(actual.contains(5));
    assertFalse(actual.contains(6));
  }

  @Test
  public void testHasUuid() {
    Map<String, String> params = new HashMap<>();
    params.put("uuid", "6713c3adffbb41b9890d77fc1673960e");

    List<Submission> scores = new ArrayList<>();
    scores.add(new Submission().id("bcba8b32bab74e6dbc87bb607cbf54f1"));
    scores.add(new Submission().id("a6bd6843c35f40f993b4bf64ef876f7a"));
    scores.add(new Submission().id("6713c3adffbb41b9890d77fc1673960e"));
    scores.add(new Submission().id("3e78af9f3b8f46b39fa5a5e56051cd78"));

    SubmissionFetcherPredicateBuilder predicateBuilder = new SubmissionFetcherPredicateBuilder(params);
    List<String> actual = scores.stream()
            .filter(predicateBuilder.hasUuid())
            .map(Submission::getId)
            .collect(Collectors.toList());
    
    assertFalse(actual.contains("bcba8b32bab74e6dbc87bb607cbf54f1"));
    assertFalse(actual.contains("a6bd6843c35f40f993b4bf64ef876f7a"));
    assertTrue(actual.contains("6713c3adffbb41b9890d77fc1673960e"));
    assertFalse(actual.contains("3e78af9f3b8f46b39fa5a5e56051cd78"));
  }

}
