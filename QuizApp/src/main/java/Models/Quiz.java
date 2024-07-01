package Models;

import java.util.ArrayList;



public class Quiz {
    public enum DisplayType {OnePage, MultiplePage};

    public final ArrayList<Question> questions;
    public String description;
    public boolean randomize;
    public DisplayType displayType;
    public boolean immediateCorrection;

    public Quiz(ArrayList<Question> questions, String description, boolean randomize, DisplayType displayType, boolean immediateCorrection){
        this.questions = questions;
        this.description = description;
        this.randomize = randomize;
        this.displayType = displayType;
        this.immediateCorrection = immediateCorrection;
    }
}
