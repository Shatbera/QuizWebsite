package models.quizzes;

import java.util.List;

public class FriendQuizAttempt {
    private int id;
    private String username;
    private String email;
    private List<QuizAttempt> quizAttemptList;
    public FriendQuizAttempt(int id, String username, String email, List<QuizAttempt> quizAttemptList) {
        this.username = username;
        this.email = email;
        this.quizAttemptList = quizAttemptList;
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public List<QuizAttempt> getQuizAttemptList() {
        return quizAttemptList;
    }

    public int getId() {
        return id;
    }
}
