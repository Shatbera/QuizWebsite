package models.quizzes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class Question {
    public enum QuestionType {QUESTION_RESPONSE, FILL_IN_BLANK, MULTI_CHOICE, PICTURE_RESPONSE, MULTI_ANSWER, MULTI_CHOICE_MULTI_ANSWER, MATCHING}
    public final int id;
    public QuestionType questionType;
    public String questionText;

    private ArrayList<Answer> answers;
    private HashMap<String, String> matchesMap;
    private ArrayList<MatchingAnswer> matchingAnswers;

    private Answer submittedAnswer;
    private ArrayList<Answer> submittedAnswers;

    private int score = 0;
    private int maxScore = 1;

    private boolean submitted = false;

    public Question(int id, QuestionType questionType, String questionText){
        this.id = id;
        this.questionType = questionType;
        this.questionText = questionText;
    }

    public boolean isSubmitted(){
        return submitted;
    }

    public int getScore(){
        return score;
    }

    public int getMaxScore(){
        return maxScore;
    }

    public Answer getSubmittedAnswer(){
        return submittedAnswer;
    }

    public ArrayList<Answer> getSubmittedAnswers(){
        return submittedAnswers;
    }

    public void setAnswers(ArrayList<Answer> answers){
        this.answers = answers;
        if(questionType == QuestionType.MULTI_ANSWER){
            maxScore = 0;
            for(Answer answer : answers){
                if(answer.isCorrect)
                    maxScore++;
            }
        }
    }

    public void setMatchingAnswers(ArrayList<MatchingAnswer> matchingAnswers) {
        this.matchingAnswers = matchingAnswers;
        matchesMap = new HashMap<>();
        for(MatchingAnswer matchingAnswer : matchingAnswers){
            matchesMap.put(matchingAnswer.leftMatch, matchingAnswer.rightMatch);
        }
    }

    public ArrayList<Answer> getAnswers() {
        return answers;
    }

    public String getCorrectAnswer(){
        return answers.get(0).toString();
    }

    public ArrayList<String> getCorrectAnswers(){
        ArrayList<String> correctAnswers = new ArrayList<>();
        for(Answer answer : answers){
            if(answer.isCorrect)
                correctAnswers.add(answer.toString());
        }
        return correctAnswers;
    }


    public ArrayList<MatchingAnswer> getMatchingAnswers() {
        return matchingAnswers;
    }

    public int submitAnswer(String selectedAnswer){
        if(selectedAnswer == null){
            submittedAnswer = new Answer("No Answer", false);
            submitted = true;
            return 0;
        }
        score = 0;
        for(Answer answer : answers){
            if(answer.isCorrect && answer.toString().equalsIgnoreCase(selectedAnswer)){
                score = 1;
                break;
            }
        }
        submittedAnswer = new Answer(selectedAnswer, score > 0);
        submitted = true;
        return score;
    }

    public int submitMultipleAnswers(ArrayList<String> selectedAnswers){
        if(selectedAnswers == null){
            submittedAnswers = new ArrayList<>();
            submittedAnswers.add(new Answer("No Answers", false));
            submitted = true;
            return 0;
        }
        score = 0;
        submittedAnswers = new ArrayList<>();
        if(questionType == QuestionType.MULTI_ANSWER){
            HashSet<String> checkedAnswers = new HashSet<>();
            for(int i = 0; i < selectedAnswers.size(); i++){
                String selectedAnswer = selectedAnswers.get(i);
                if(checkedAnswers.contains(selectedAnswer)){
                    continue;
                }
                boolean isCorrect = false;
                checkedAnswers.add(selectedAnswer);
                for(Answer answer : answers){
                    if(answer.isCorrect && answer.toString().equalsIgnoreCase(selectedAnswer)){
                        if(answer.order == 0 || answer.order == i + 1){
                            score++;
                            isCorrect = true;
                        }
                    }
                }
                submittedAnswers.add(new Answer(selectedAnswer, isCorrect));
            }
        }else if(questionType == QuestionType.MULTI_CHOICE_MULTI_ANSWER){
            score = 1;
            for(Answer answer : answers){
                if(answer.isCorrect && !selectedAnswers.contains(answer.toString())){
                    score = 0;
                }
                if(!answer.isCorrect && selectedAnswers.contains(answer.toString())){
                    score = 0;
                }
            }
            ArrayList<String> correctAnswers = getCorrectAnswers();
            for(String selectedAnswer : selectedAnswers){
                boolean isCorrect = correctAnswers.contains(selectedAnswer);
                submittedAnswers.add(new Answer(selectedAnswer, isCorrect));
            }
        }
        submitted = true;
        return score;
    }

    public int submitMatches(ArrayList<String> leftMatches, ArrayList<String> rightMatches){
        score = 1;
        submittedAnswers = new ArrayList<>();
        for(int i = 0; i < leftMatches.size(); i++){
            String left = leftMatches.get(i);
            String right = rightMatches.get(i);
            if(!matchesMap.containsKey(left) || !matchesMap.get(left).equals(right)){
                score = 0;
                submittedAnswers.add(new Answer(right, false));
            }else{
                submittedAnswers.add(new Answer(right, true));
            }
        }
        submitted = true;
        return score;
    }
}
