package config;

import com.mysql.cj.util.StringUtils;
import models.enums.FriendRequestType;
import models.quizzes.Answer;
import models.quizzes.MatchingAnswer;
import models.quizzes.Question;
import models.quizzes.Quiz;
import models.user.User;
import models.user.UserProfile;

import java.sql.*;
import java.util.ArrayList;
import java.util.Optional;

public class DatabaseManager {

    public static final String NAME = "databaseManager";
    private static final String database = "mydatabase";

    private Statement statement;

    public DatabaseManager() {
        try {
            Connection connection = DatabaseConfig.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            statement.execute("USE " + database);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Quiz getQuiz(int id) {
        try {
            ResultSet rs = statement.executeQuery(QueryGenerator.getQuiz(id));
            if (rs.next()) {
                return getQuizObject(rs);
            } else return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Quiz> getAllQuizzes() {
        ArrayList<Quiz> quizzes = new ArrayList<>();
        try {
            ResultSet rs = statement.executeQuery(QueryGenerator.getAllQuizzes());
            while (rs.next()) {
                Quiz quiz = getQuizObject(rs);
                quizzes.add(quiz);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return quizzes;
    }


    public ArrayList<Question> getQuizQuestions(int quizId) {
        ArrayList<Question> questions = new ArrayList<>();

        try {
            ResultSet rs = statement.executeQuery(QueryGenerator.getQuizQuestions(quizId));
            while (rs.next()) {
                Question question = getQuestionObject(rs);
                questions.add(question);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return questions;
    }

    private Question getQuestionObject(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String questionText = rs.getString("question_text");
        String questionType = rs.getString("question_type");
        return new Question(id, getQuestionType(questionType), questionText);
    }

    private Question.QuestionType getQuestionType(String type) {
        switch (type) {
            case "question_response":
                return Question.QuestionType.QUESTION_RESPONSE;
            case "fill_in_blank":
                return Question.QuestionType.FILL_IN_BLANK;
            case "multi_choice":
                return Question.QuestionType.MULTI_CHOICE;
            case "picture_response":
                return Question.QuestionType.PICTURE_RESPONSE;
            case "multi_answer":
                return Question.QuestionType.MULTI_ANSWER;
            case "multi_choice_multi_answer":
                return Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER;
            case "matching":
                return Question.QuestionType.MATCHING;
        }
        return Question.QuestionType.QUESTION_RESPONSE;
    }

    public ArrayList<Answer> getAnswers(int questionId) {
        ArrayList<Answer> answers = new ArrayList<>();
        try {
            ResultSet rs = statement.executeQuery(QueryGenerator.getAnswers(questionId));
            while (rs.next()) {
                int id = rs.getInt("id");
                String ans = rs.getString("answer");
                boolean isCorrect = rs.getBoolean("is_correct");
                int order = rs.getInt("answer_order");
                answers.add(new Answer(id, ans, isCorrect, order));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return answers;
    }

    public ArrayList<MatchingAnswer> getMatchingAnswers(int questionId) {
        ArrayList<MatchingAnswer> answers = new ArrayList<>();
        try {
            ResultSet rs = statement.executeQuery(QueryGenerator.getMatchingAnswers(questionId));
            while (rs.next()) {
                int id = rs.getInt("id");
                String leftMatch = rs.getString("left_match");
                String rightMatch = rs.getString("right_match");
                answers.add(new MatchingAnswer(id, leftMatch, rightMatch));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return answers;
    }

    private Quiz getQuizObject(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        int userId = rs.getInt("user_id");
        String title = rs.getString("title");
        String description = rs.getString("description");
        boolean randomize = rs.getInt("randomize") == 1;
        String displayType = rs.getString("display_type");
        boolean immediateCorrection = rs.getInt("immediate_correction") == 1;

        Quiz.DisplayType quizDisplayType = displayType.equals("one_page") ? Quiz.DisplayType.OnePage : Quiz.DisplayType.MultiplePage;

        return new Quiz(id, userId, title, description, randomize, quizDisplayType, immediateCorrection);
    }

    public Optional<Integer> checkUserCredentials(String username, String hashedPassword) {
        try {
            ResultSet resultSet = statement.executeQuery(QueryGenerator.isValidUser(username, hashedPassword));
            return Optional.ofNullable(resultSet.next() ? resultSet.getInt("id") : null);

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }


    public boolean saveUser(String username, String email, String hashedPassword) {
        try {
            int update = statement.executeUpdate(QueryGenerator.saveUser(username, email, hashedPassword));
            return update > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public ArrayList<User> searchUsers(String prompt, String currentUser) {
        ArrayList<User> users = new ArrayList<>();
        try {
            ResultSet resultSet = statement.executeQuery(QueryGenerator.searchUsers(prompt, currentUser));
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String username = resultSet.getString("username");
                String email = resultSet.getString("email");
                users.add(new User(id, username, email));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }

    public UserProfile getUserProfile(String username, int currentUserId) {
        try {
            ResultSet resultSet = statement.executeQuery(QueryGenerator.getUserProfile(username, currentUserId));
            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String username1 = resultSet.getString("username");
                String email = resultSet.getString("email");
                String friendshipType = resultSet.getString("friendship_type");
                boolean isFriend = false;
                FriendRequestType friendRequestType = null;

                if (friendshipType != null) {
                    isFriend = friendshipType.equals("ACCEPTED");
                    friendRequestType = FriendRequestType.valueOf(friendshipType);
                }

                return new UserProfile(id, username1, email, isFriend, friendRequestType);
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
