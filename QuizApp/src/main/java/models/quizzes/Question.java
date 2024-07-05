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

    private int score = 0;
    private int maxScore = 1;

    public Question(int id, QuestionType questionType, String questionText){
        this.id = id;
        this.questionType = questionType;
        this.questionText = questionText;
    }

    public int getScore(){
        return score;
    }

    public int getMaxScore(){
        return maxScore;
    }

    public void setAnswers(ArrayList<Answer> answers){
        this.answers = answers;
        if(questionType == QuestionType.MULTI_ANSWER){
            maxScore = answers.size();
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

    public ArrayList<MatchingAnswer> getMatchingAnswers() {
        return matchingAnswers;
    }

    public int submitAnswer(String selectedAnswer){
        score = 0;
        for(Answer answer : answers){
            if(answer.isCorrect && answer.toString().equalsIgnoreCase(selectedAnswer)){
                score = 1;
                break;
            }
        }
        return score;
    }

    public int submitMultipleAnswers(ArrayList<String> selectedAnswers){
        score = 0;
        if(questionType == QuestionType.MULTI_ANSWER){
            HashSet<String> checkedAnswers = new HashSet<>();
            for(int i = 0; i < selectedAnswers.size(); i++){
                String selectedAnswer = selectedAnswers.get(i);
                if(checkedAnswers.contains(selectedAnswer)){
                    continue;
                }
                checkedAnswers.add(selectedAnswer);
                for(Answer answer : answers){
                    if(answer.isCorrect && answer.toString().equalsIgnoreCase(selectedAnswer)){
                        if(answer.order == 0 || answer.order == i + 1){
                            score++;
                        }
                    }
                }
            }
        }else if(questionType == QuestionType.MULTI_CHOICE_MULTI_ANSWER){
            for(Answer answer : answers){
                if(answer.isCorrect && !selectedAnswers.contains(answer.toString())){
                    return 0;
                }
                if(!answer.isCorrect && selectedAnswers.contains(answer.toString())){
                    return 0;
                }
            }
            score = 1;
        }
        return score;
    }

    public int submitMatches(ArrayList<String> leftMatches, ArrayList<String> rightMatches){
        score = 0;
        for(int i = 0; i < leftMatches.size(); i++){
            String left = leftMatches.get(i);
            String right = rightMatches.get(i);
            if(!matchesMap.containsKey(left) || !matchesMap.get(left).equals(right)){
                return 0;
            }
        }
        score = 1;
        return score;
    }
}
