package Models.quizzes;

public class Question {
    public enum QuestionType {QUESTION_RESPONSE, FILL_IN_BLANK, MULTI_CHOICE, PICTURE_RESPONSE, MULTI_ANSWER, MULTI_CHOICE_MULTI_ANSWER, MATCHING}
    public final int id;
    public QuestionType questionType;
    public String questionText;

    public Question(int id, QuestionType questionType, String questionText){
        this.id = id;
        this.questionType = questionType;
        this.questionText = questionText;
    }
}
