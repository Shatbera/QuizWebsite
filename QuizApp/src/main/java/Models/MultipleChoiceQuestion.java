package Models;

import java.util.ArrayList;

public class MultipleChoiceQuestion extends Question{
    private String question;
    private ArrayList<String> answers; //first numberOfCorrectAnswers answers are correct, others are wrong
    private int numberOfCorrectAnswers;

    public MultipleChoiceQuestion(String question, ArrayList<String> answers, int numberOfCorrectAnswers){
        this.questionType = numberOfCorrectAnswers > 1 ? QuestionType.MULTI_CHOICE_MULTI_ANSWER : QuestionType.MULTI_CHOICE;
        this.question = question;
        this.answers = answers;
        this.numberOfCorrectAnswers = numberOfCorrectAnswers;
    }

    public MultipleChoiceQuestion(String question, ArrayList<String> answers){
        this(question, answers, 1);
    }

    public String getQuestion(){
        return question;
    }

    public boolean checkAnswer(String answer){
        return answer.equals(answers.get(0));
    }

    public boolean checkSelectedAnswers(ArrayList<String> selectedAnswers){
        for(int i = 0; i < numberOfCorrectAnswers; i++){
            if(!selectedAnswers.contains(answers.get(i)))
                return false;
        }
        return true;
    }
}
