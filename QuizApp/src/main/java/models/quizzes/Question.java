package models.quizzes;

import java.lang.reflect.Array;
import java.util.ArrayList;

public class Question {
    public enum QuestionType {QUESTION_RESPONSE, FILL_IN_BLANK, MULTI_CHOICE, PICTURE_RESPONSE, MULTI_ANSWER, MULTI_CHOICE_MULTI_ANSWER, MATCHING}
    public final int id;
    public QuestionType questionType;
    public String questionText;

    private ArrayList<Answer> answers;
    private ArrayList<MatchingAnswer> matchingAnswers;

    private int score = 0;
    private int maxScore = 1;

    public Question(int id, QuestionType questionType, String questionText){
        this.id = id;
        this.questionType = questionType;
        this.questionText = questionText;
    }

    public void setAnswers(ArrayList<Answer> answers){
        this.answers = answers;
        if(questionType == QuestionType.MULTI_ANSWER){
            maxScore = answers.size();
        }
    }

    public void setMatchingAnswers(ArrayList<MatchingAnswer> matchingAnswers) {
        this.matchingAnswers = matchingAnswers;
    }

    public ArrayList<Answer> getAnswers() {
        return answers;
    }

    public ArrayList<MatchingAnswer> getMatchingAnswers() {
        return matchingAnswers;
    }

    public void submitAnswer(String selectedAnswer){

    }

    public void submitMultipleAnswers(ArrayList<String> selectedAnswers){
        int score = 0;
        for(int i = 0; i < answers.size(); i++){
            
        }
        score += score;
    }

    public void submitMatches(ArrayList<String> leftMatches, ArrayList<String> rightMatches){

    }


}
