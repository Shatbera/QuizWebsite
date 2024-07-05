package config;

public class QueryGenerator {
    public static String getAllQuizzes() {
        return "SELECT * FROM quizzes";
    }

    public static String getQuizQuestions(int quizId) {
        return String.format("SELECT * FROM questions WHERE quiz_id = %s;", quizId);
    }

    public static String getAnswers(int questionId) {
        return String.format("SELECT * FROM answers WHERE question_id = %s;", questionId);
    }

    public static String getMatchingAnswers(int questionId) {
        return String.format("SELECT * FROM matches WHERE question_id = %s;", questionId);
    }

    public static String getQuiz(int id) {
        return String.format("SELECT * FROM quizzes WHERE id = %s;", id);
    }

    public static String isValidUser(String username, String hashedPassword) {
        return String.format("select * from users where username = %s and password_hashed = %s", quoted(username), quoted(hashedPassword));
    }

    public static String saveUser(String username, String email, String hashedPassword) {
        return String.format("insert into users (username, email, password_hashed) values (%s, %s, %s)",
                quoted(username), quoted(email), quoted(hashedPassword));
    }

    public static String searchUsers(String prompt, String currentUser) {
        return String.format("select * from users where (lower(email) like %s or lower(username) like %s) and username <> %s",
                quoted("%".concat(prompt).concat("%")),
                quoted("%".concat(prompt).concat("%")), quoted(currentUser));
    }

    public static String getUserProfile(String username, int currentUserId) {
        return String.format("select u.id as id, u.username as username, u.email as email, f.friendship_type as friendship_type from users u left join friends f on ((u.id = f.receiver_id and f.sender_id = %s) or (u.id = f.sender_id and f.receiver_id = %s)) where u.username = %s",
                currentUserId, currentUserId, quoted(username));
    }
    private static String quoted(String str) {
        return String.format("\"%s\"", str);
    }

}
