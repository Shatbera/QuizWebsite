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
                id, userId, score, timeTaken);
    }

    public static String fetchCreatedQuizzes(int id) {
        return String.format("select * from quizzes where user_id = %s", id);
    }

    public static String fetchTopThreePopularQuizzes() {
        return "select q.*, count(distinct qa.user_id) as unique_users " +
               "from quizzes q " +
               "join quiz_attempts qa on q.id = qa.quiz_id " +
               "group by q.id " +
               "order by unique_users desc " +
               "limit 3";
    }

    public static String fetchThreeMostRecentQuizzes() {
        return "select * from quizzes order by time_created desc limit 3";
    }

    public static String fetchPastResults(int userId, int quizId, String sortField, String sortDirection) {
        String sql = String.format("select score as score, attempt_time as attemptTime, time_taken as timeTaken " +
                                   "from (select qa.score, qa.attempt_time, qa.time_taken, row_number() over (order by qa.attempt_time desc) as row_num " +
                                   "from quiz_attempts qa " +
                                   "join quizzes q on qa.quiz_id = q.id " +
                                   "where qa.user_id = %s and qa.quiz_id = %s) as tbl " +
                                   "where row_num >= 1 ", userId, quizId);
        if (sortField != null && sortDirection != null) {
            switch (sortField) {
                case "score":
                    sql += "order by score " + sortDirection;
                    break;
                case "timeTaken":
                    sql += "order by timeTaken " + sortDirection;
                    break;
                case "attemptTime":
                    sql += "order by attemptTime " + sortDirection;
                    break;
                default:
                    sql += "order by attemptTime desc";
                    break;
            }
        } else {
            sql += "order by attemptTime desc";
        }
        return sql;
    }

    public static String createQuiz(int userId, String title, String description, boolean randomize, String displayType, boolean immediateCorrection, int maxScore) {
        return String.format("INSERT INTO quizzes (user_id, title, description, randomize, display_type, immediate_correction, max_score) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                userId, quoted(title), quoted(description), randomize, quoted(displayType), immediateCorrection, maxScore);
    }

    public static String createQuestion(int quizId, String questionType, String questionText) {
        return String.format("INSERT INTO questions (quiz_id, question_type, question_text) VALUES (%s, %s, %s)",
                quizId, quoted(questionType), quoted(questionText));
    }

    public static String createAnswer(int questionId, String answer, boolean isCorrect, int answerOrder) {
        return String.format("INSERT INTO answers (question_id, answer, is_correct, answer_order) VALUES (%s, %s, %s, %s)",
                questionId, quoted(answer), isCorrect, answerOrder);
    }

    public static String createMatchingAnswer(int questionId, String leftMatch, String rightMatch) {
        return String.format("INSERT INTO matches (question_id, left_match, right_match) VALUES (%s, %s, %s)",
                questionId, quoted(leftMatch), quoted(rightMatch));
    }

    public static String fetchUserRecentActivity(int userId) {
        return String.format("with rankedAttempts as (select qa.time_taken as timeTaken, " +
                             "qa.score as score, " +
                             "q.title as title, " +
                             "q.description as description, " +
                             "qa.attempt_time as attemptTime, " +
                             "row_number() over (partition by qa.quiz_id order by qa.attempt_time desc) as rn " +
                             "from quiz_attempts qa " +
                             "join quizzes q on qa.quiz_id = q.id " +
                             "where qa.user_id = %s) " +
                             "select * " +
                             "from rankedAttempts " +
                             "where rn = 1 " +
                             "order by attemptTime desc " +
                             "limit 3", userId);
    }

    public static String getQuizCreator(int id) {
        return String.format("select u.id as id, u.username as username, u.email as email from users u join quizzes q on q.user_id = u.id where q.id = %s", id);
    }

    public static String fetchQuizPerformers(int id, boolean allTime) {
        return String.format("select ranked.id as id, ranked.username as username, ranked.email as email, ranked.time_taken as timeTaken, ranked.score as score " +
                             "from (select u.id, " +
                             "u.username," +
                             "u.email," +
                             "qa.time_taken, " +
                             "qa.score, " +
                             "row_number() over (partition by u.id order by qa.score desc, qa.time_taken) as rn " +
                             "from users u " +
                             "join quiz_attempts qa on u.id = qa.user_id " +
                             "join quizzes q on qa.quiz_id = q.id " +
                             "where q.id = %s" +
                             (!allTime ? "%s" : "") +
                             ") as ranked " +
                             "where rn = 1 " +
                             "order by score desc, timeTaken " +
                             "limit 3", id, " and date(qa.attempt_time) = current_date()");
    }


    public static String fetchRecentQuizPerformers(int id) {
        return String.format("select u.id          as id, " +
                             "u.username    as username, " +
                             "u.email       as email, " +
                             "qa.time_taken as timeTaken, " +
                             "qa.score      as score, " +
                             "qa.attempt_time as attemptTime " +
                             "from quizzes q " +
                             "join quiz_attempts qa on q.id = qa.quiz_id " +
                             "join users u on qa.user_id = u.id " +
                             "where q.id = %s " +
                             "order by qa.attempt_time desc limit 3", id);
    }

    public static String getQuizStatistics(int id) {
        return String.format("select avg(qa.score)      as avg_score, " +
                             "       avg(qa.time_taken) as avg_time_taken, " +
                             "       count(qa.id)       as total_attempts, " +
                             "       q.max_score        as max_score, " +
                             "       avg(qr.stars)      as avg_rating " +
                             "from quizzes q " +
                             "         left join quiz_attempts qa " +
                             "                   on q.id = qa.quiz_id " +
                             "         left join quiz_ratings qr on qr.quiz_id = q.id " +
                             "where q.id = %d", id);
    }

    public static String fetchFriendsQuizAttempts(int userId, int quizId) {
        return String.format("select u.id as userId, u.username as username, u.email as email, qa.time_taken as time_taken, qa.score as score, qa.attempt_time as attempt_time " +
                             "from quiz_attempts qa " +
                             "join users u on qa.user_id = u.id " +
                             "where qa.quiz_id = %s " +
                             "and qa.user_id in (select innerU.id " +
                             "from users innerU " +
                             "join friends f on ((innerU.id = f.receiver_id and f.sender_id = %s) or " +
                             "(innerU.id = f.sender_id and f.receiver_id = %s) and f.friendship_type = 'APPROVED')) " +
                             "order by u.id, qa.attempt_time desc", quizId, userId, userId);
    }

    public static String saveRating(int id, int userId, int rating, String review) {
        return String.format("insert into quiz_ratings (quiz_id, user_id, stars, review) values (%s, %s, %s, %s)",
                id, userId, rating, quoted(review));
    }
}
