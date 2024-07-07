package models.quizzes;

public class UserQuizRecentAttemptShort {
    int timeTaken;
    int score;
    String description;
    String title;
    String attemptTime;

    public UserQuizRecentAttemptShort(int timeTaken, int score, String description, String title, String attemptTime) {
        this.timeTaken = timeTaken;
        this.score = score;
        this.description = description;
        this.title = title;
        this.attemptTime = attemptTime;
    }

    public int getTimeTaken() {
        return timeTaken;
    }

    public int getScore() {
        return score;
    }

    public String getDescription() {
        return description;
    }

    public String getTitle() {
        return title;
    }

    public String getAttemptTime() {
        return attemptTime;
    }
}
