package Models.quizzes;


public class Quiz {
    public enum DisplayType {OnePage, MultiplePage};

    public final int id;
    public final int userId;
    public String title;
    public String description;
    public boolean randomize;
    public DisplayType displayType;
    public boolean immediateCorrection;

    public Quiz(int id, int userId, String title, String description, boolean randomize, DisplayType displayType, boolean immediateCorrection){
        this.id = id;
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.randomize = randomize;
        this.displayType = displayType;
        this.immediateCorrection = immediateCorrection;
    }
}
