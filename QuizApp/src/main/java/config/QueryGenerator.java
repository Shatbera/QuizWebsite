package config;

import models.enums.FriendRequestType;

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
        return String.format("select u.id as id, u.username as username, u.email as email, f.friendship_type as friendship_type, f.sender_id as sender_id, f.receiver_id as receiver_id from users u left join friends f on ((u.id = f.receiver_id and f.sender_id = %s) or (u.id = f.sender_id and f.receiver_id = %s)) where u.username = %s",
                currentUserId, currentUserId, quoted(username));
    }

    private static String quoted(String str) {
        return String.format("\"%s\"", str);
    }

    public static String sendFriendRequest(int fromUserId, int toUserId) {
        return String.format("insert into friends (sender_id, receiver_id, friendship_type) values (%s, %s, %s)",
                fromUserId, toUserId, quoted(FriendRequestType.PENDING.name()));
    }

    public static String acceptFriendRequest(int fromUserId, int toUserId) {
        return String.format("update friends set friendship_type = 'APPROVED' where sender_id = %s and receiver_id = %s",
                fromUserId, toUserId);
    }

    public static String deleteFromFriends(int fromUserId, int toUserId) {
        return String.format("delete from friends where sender_id = %s and receiver_id = %s",
                fromUserId, toUserId);
    }

    public static String fetchFriendRequests(int id) {
        return String.format("select u.id as id, u.username as username from users u join friends f on (f.sender_id = u.id) where f.friendship_type = 'PENDING' and f.receiver_id = %s",
                id);
    }

    public static String fetchFriends(int id) {
        return String.format("select u.id as id, u.username as username from users u join friends f on ((f.sender_id = u.id and f.receiver_id = %s) or (f.sender_id = %s and f.receiver_id = u.id)) where f.friendship_type = 'APPROVED'",
                id, id);
    }

    public static String getUserId(String username) {
        return String.format("select id as id from users where username = %s", quoted(username));
    }

    public static String fetchMessages(int id) {
        return String.format("select u.id as id, u.username as username, m.message as message, m.send_time as sendTime from user_messages m join users u on m.sender_id = u.id where m.recipient_id = %s", id);
    }

    public static String addMessage(int senderId, int recipientId, String message) {
        return String.format("insert into user_messages (sender_id, recipient_id, message) values (%s, %s, %s)",
                senderId, recipientId, quoted(message));
    }

    public static String saveQuizAttempt(int userId, int id, int score, int timeTaken) {
        return String.format("insert into quiz_attempts (quiz_id, user_id, score, time_taken) values (%s, %s, %s, %s)",
                userId, id, score, timeTaken);
    }
}
