package models.quizzes;


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
}
