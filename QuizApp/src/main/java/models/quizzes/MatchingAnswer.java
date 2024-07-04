package models.quizzes;

public class MatchingAnswer {
    public final int id;
    public String leftMatch;
    public String rightMatch;

    public MatchingAnswer(int id, String leftMatch, String rightMatch){
        this.id = id;
        this.leftMatch = leftMatch;
        this.rightMatch = rightMatch;
    }
}
