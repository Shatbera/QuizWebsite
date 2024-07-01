package Models;

import java.util.ArrayList;
import java.util.HashSet;

public class MultiAnswerQuestion extends Question{
    private String question;
    private ArrayList<String> correctAnswers;
    private int maxAnswers;
    private boolean orderMatters;

    public MultiAnswerQuestion(String question, ArrayList<String> correctAnswers, int maxAnswers, boolean orderMatters){
        this.questionType = QuestionType.MULTI_ANSWER;
        this.question = question;
        this.correctAnswers = correctAnswers;
        this.maxAnswers = maxAnswers;
        this.orderMatters = orderMatters;
    }

    public int countCorrectAnswers(ArrayList<String> selectedAnswers){
        int correctCount = 0;
        if(orderMatters){
            for(int i = 0; i < selectedAnswers.size(); i++){
                if(correctAnswers.get(i).equals(selectedAnswers.get(i))){
                    correctCount++;
                }
            }
        }else{
            HashSet<String> checkedAnswers = new HashSet<>();
            for(String answer : selectedAnswers){
                if(!checkedAnswers.contains(answer) && correctAnswers.contains(answer)){
                    correctCount++;
                    checkedAnswers.add(answer);
                }
            }
        }
        return correctCount;
    }

    public String getQuestion(){
        return question;
    }

    public int getMaxAnswers(){
        return maxAnswers;
    }
}
