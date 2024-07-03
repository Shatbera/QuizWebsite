package Models;

public class Answer {
    public String answer;
    public boolean isCorrect;
    public int order;

    public Answer(String answer, boolean isCorrect, int order){
        this.answer = answer;
        this.isCorrect = isCorrect;
        this.order = order;
    }
}
