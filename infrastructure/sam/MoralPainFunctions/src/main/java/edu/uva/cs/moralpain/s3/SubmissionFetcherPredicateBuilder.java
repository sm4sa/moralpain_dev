package edu.uva.cs.moralpain.s3;

import org.openapitools.client.model.Submission;

import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.function.Predicate;

/**
 * Construct predicates based on the parameters sent in the request.
 *
 */
public class SubmissionFetcherPredicateBuilder {
    private Map<String, String> queryStringParams;

    public SubmissionFetcherPredicateBuilder(Map<String, String> queryStringParams) {
        this.queryStringParams = queryStringParams;
    }

    public Predicate<String> beforeOrAtEndTime() {
        String end = this.queryStringParams.getOrDefault("endtime", "");
        if(end.isEmpty()) {
            return __ -> true;
        }

        return key ->  {
            String prefix = key.substring(0, key.lastIndexOf("/"));
            DateTimeFormatter formatter = DateTimeFormatter
                    .ofPattern("y/MM/dd/HH/mm/ss")
                    .withZone(ZoneId.from(ZoneOffset.UTC));
            Instant keyInstant = Instant.from(formatter.parse(prefix));
            Instant endInstant = Instant.ofEpochSecond(Long.parseLong(end));
            return keyInstant.compareTo(endInstant) < 1;
        };
    }

    public Predicate<Submission> lessThanOrEqualToMaxScore() {
        String maxScore = this.queryStringParams.getOrDefault("maxscore", "");
        if (maxScore.isEmpty()) {
            return __ -> true;
        }

        return submission -> submission.getScore().compareTo(Integer.parseInt(maxScore)) < 1;
    }

    public Predicate<Submission> greaterThanOrEqualToMinScore() {
        String minScore = this.queryStringParams.getOrDefault("minscore", "");
        if (minScore.isEmpty()) {
            return __ -> true;
        }

        return submission -> submission.getScore().compareTo(Integer.parseInt(minScore)) > -1;
    }

    public Predicate<Submission> inScoreRange() {
        return lessThanOrEqualToMaxScore().and(greaterThanOrEqualToMinScore());
    }

}
