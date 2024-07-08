package models.quizzes;

public class QuizStatistics {

    private int totalAttempts;
    private double averageScore;
    private int maxScore;
    private double averageTimeTaken;
    private double percentage;

    public QuizStatistics(int totalAttempts, double averageScore, int maxScore, double averageTimeTaken) {
        this.totalAttempts = totalAttempts;
        this.averageScore = averageScore;
        this.maxScore = maxScore;
        this.averageTimeTaken = averageTimeTaken;
        this.percentage = averageScore/maxScore * 100;
    }

    public int getTotalAttempts() {
        return totalAttempts;
    }

    public double getAverageScore() {
        return averageScore;
    }

    public int getMaxScore() {
        return maxScore;
    }

    public double getAverageTimeTaken() {
        return averageTimeTaken;
    }

    public double getPercentage() {
        return percentage;
    }
}
