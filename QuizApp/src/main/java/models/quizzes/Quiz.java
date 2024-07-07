package models.quizzes;


import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;

public class Quiz {
    public enum DisplayType {OnePage, MultiplePage};


    public final int id;
    public final int userId;
    public String title;
    public String description;
    public boolean randomize;
    public DisplayType displayType;
    public boolean immediateCorrection;

    private ArrayList<Question> questions;

    private Instant quizStartTime;
    private int quizTimeTaken;

    private boolean quizEnded = false;

    public Quiz(int id, int userId, String title, String description, boolean randomize, DisplayType displayType, boolean immediateCorrection){
        this.id = id;
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.randomize = randomize;
        this.displayType = displayType;
        this.immediateCorrection = immediateCorrection;
    }

    public void setQuestions(ArrayList<Question> questions){
        this.questions = questions;
    }

    public ArrayList<Question> getQuestions() {
        return questions;
    }

    public Question getQuestion(int questionId){
        for(Question question : questions){
            if(question.id == questionId){
                return question;
            }
        }
        return null;
    }

    public void startQuiz(){
        quizStartTime = Instant.now();
    }

    public void endQuiz(){
        if(quizEnded){
            return;
        }
        quizTimeTaken = (int)Duration.between(quizStartTime, Instant.now()).getSeconds();
        quizEnded = true;
    }

    public boolean isQuizEnded(){
        return quizEnded;
    }

    public int getQuizTimeTaken(){
        return quizTimeTaken;
    }

    public int getScore(){
        int score = 0;
        for(Question question : questions){
            score += question.getScore();
        }
        return score;
    }

    public int getMaxScore(){
        int maxScore = 0;
        for(Question question : questions){
            maxScore += question.getMaxScore();
        }
        return maxScore;
    }

    public int getScorePercentage(){
        int score = getScore();
        int maxScore = getMaxScore();
        return (int)((float) 100 * score / maxScore);
    }

    public Question getNextQuestion(){
        for(Question question : questions){
            if(!question.isSubmitted())
                return question;
        }
        return null;
    }
}
