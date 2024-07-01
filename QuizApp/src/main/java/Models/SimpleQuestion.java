package Models;

import java.util.ArrayList;

//combines QuestionResponse, FillInTheBlank and PictureResponse Questions
public class SimpleQuestion extends Question{
    private String question;
    private ArrayList<String> correctAnswers;

    public SimpleQuestion(String question, ArrayList<String> correctAnswers, QuestionType questionType){
        this.questionType = questionType;
        this.question = question;
        this.correctAnswers = correctAnswers;
    }

    public String getQuestion() {
        return question;
    }

    public boolean checkAnswer(String answer){
        return correctAnswers.contains(answer);
    }
}
