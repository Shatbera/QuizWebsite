package Models.quizzes;

public class Answer {
    public final int id;
    public String answer;
    public boolean isCorrect;
    public int order; //0 means that order does not matter


    public Answer(int id, String answer, boolean isCorrect, int order){
        this.id = id;
        this.answer = answer;
        this.isCorrect = isCorrect;
        this.order = order;
    }

    @Override
    public String toString() {
        return answer;
    }
}
