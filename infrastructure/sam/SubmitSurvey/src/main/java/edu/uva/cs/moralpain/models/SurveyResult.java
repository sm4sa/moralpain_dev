package edu.uva.cs.moralpain.models;

import java.util.List;

/**
 * POJO containing a completed survey.
 */
public class SurveyResult {
    private List<String> selections;
    private int score;
    private long timestamp;
    private String id;

    public List<String> getSelections() {
        return selections;
    }

    public void setSelections(List<String> selections) {
        this.selections = selections;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
