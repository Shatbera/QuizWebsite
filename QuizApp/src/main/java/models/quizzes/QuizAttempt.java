package models.quizzes;

public class QuizAttempt {
    private int userId;
    private int quizId;
    private int score;
    private int timeTaken;
    private String attemptTime;

    public int getScore() {
        return score;
    }

    public int getUserId() {
        return userId;
    }

    public int getQuizId() {
        return quizId;
    }

    public int getTimeTaken() {
        return timeTaken;
    }

    public String getAttemptTime() {
        return attemptTime;
    }

    public QuizAttempt(int userId, int quizId, int score, int timeTaken, String attemptTime) {
        this.userId = userId;
        this.quizId = quizId;
        this.score = score;
        this.timeTaken = timeTaken;
        this.attemptTime = attemptTime;
    }
    public QuizAttempt(int score, int timeTaken, String attemptTime) {
        this.score = score;
        this.timeTaken = timeTaken;
        this.attemptTime = attemptTime;
    }

}
