package models.quizzes;

public class QuizPerformerResponse {
    private int userId;
    private String username;
    private String email;
    private int score;
    private int timeTaken;

    public QuizPerformerResponse(int userId, String username, String email, int score, int timeTaken) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.score = score;
        this.timeTaken = timeTaken;
    }

    public int getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public int getScore() {
        return score;
    }

    public int getTimeTaken() {
        return timeTaken;
    }

}
