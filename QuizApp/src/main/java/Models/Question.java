package Models;

public abstract class Question {
    public enum QuestionType {QUESTION_RESPONSE, FILL_IN_BLANK, MULTI_CHOICE, PICTURE_RESPONSE, MULTI_ANSWER, MULTI_CHOICE_MULTI_ANSWER, MATCHING}
    protected QuestionType questionType;

    public QuestionType getQuestionType(){
        return questionType;
    }
}
