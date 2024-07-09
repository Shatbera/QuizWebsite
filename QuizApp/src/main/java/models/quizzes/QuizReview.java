package models.quizzes;

public class QuizReview {
    public final int stars;
    public final String review;
    public final String userName;
    public QuizReview(int stars, String review, String userName) {
        this.stars = stars;
        this.review = review;
        this.userName = userName;
    }
}
