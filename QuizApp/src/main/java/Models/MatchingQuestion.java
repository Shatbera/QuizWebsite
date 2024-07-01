package Models;

import java.util.ArrayList;

public class MatchingQuestion extends Question{
    private ArrayList<String> questions;
    private ArrayList<String> answers;

    public MatchingQuestion(ArrayList<String> questions, ArrayList<String> answers){
        this.questionType = QuestionType.MATCHING;
        this.questions = questions;
        this.answers = answers;
    }

    private ArrayList<String> getQuestions(){
        return questions;
    }

    private ArrayList<String> getAnswers(){
        return answers;
    }

    private boolean checkAnswers(ArrayList<String> selectedAnswers){
        for(int i = 0; i < selectedAnswers.size(); i++){
            if(!selectedAnswers.get(i).equals(answers.get(i)))
                return false;
        }
        return true;
    }
}
