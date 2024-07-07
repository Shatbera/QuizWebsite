package config;

import models.enums.FriendRequestType;
import models.quizzes.*;
import models.user.*;
import util.Utils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
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
        return new Question(id, stringToQuestionType(questionType), questionText);
    }

    private Question.QuestionType stringToQuestionType(String type) {
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

    public Integer getUserId(String username) {
        try {
            ResultSet execute = statement.executeQuery(QueryGenerator.getUserId(username));
            if (execute.next()) {
                return execute.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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
                Integer senderId = Optional.ofNullable(resultSet.getInt("sender_id")).orElse(null);
                Integer receiverId = Optional.ofNullable(resultSet.getInt("receiver_id")).orElse(null);
                boolean isFriend = false;
                FriendRequestType friendRequestType = null;

                if (friendshipType != null) {
                    isFriend = friendshipType.equals("APPROVED");
                    friendRequestType = FriendRequestType.valueOf(friendshipType);
                }

                return new UserProfile(id, username1, email, isFriend, senderId, receiverId, friendRequestType);
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean sendFriendRequest(int fromUserId, int toUserId) {
        try {
            int executed = statement.executeUpdate(QueryGenerator.sendFriendRequest(fromUserId, toUserId));
            return executed > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean acceptFriendRequest(int fromUserId, int toUserId) {
        try {
            int executed = statement.executeUpdate(QueryGenerator.acceptFriendRequest(fromUserId, toUserId));
            return executed > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean deleteFriendRequest(int fromUserId, int toUserId) {
        try {
            int executed = statement.executeUpdate(QueryGenerator.deleteFromFriends(fromUserId, toUserId));
            return executed > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public ArrayList<FriendResponse> getFriendRequests(int id) {
        ArrayList<FriendResponse> users = new ArrayList<>();
        try {
            ResultSet resultSet = statement.executeQuery(QueryGenerator.fetchFriendRequests(id));
            while (resultSet.next()) {
                users.add(new FriendResponse(resultSet.getInt("id"), resultSet.getString("username")));
            }
            return users;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<FriendMessage> fetchFriendMessages(int id) {
        ArrayList<FriendMessage> messages = new ArrayList<>();
        try {
            ResultSet resultSet = statement.executeQuery(QueryGenerator.fetchMessages(id));
            while (resultSet.next()) {
                int senderId = resultSet.getInt("id");
                String senderUsername = resultSet.getString("username");
                String message = resultSet.getString("message");
                Timestamp sendTime = resultSet.getTimestamp("sendTime");
                Optional<FriendMessage> friendMessage = messages.stream().filter(m -> m.getSenderId() == senderId).findFirst();
                if (friendMessage.isPresent()) {
                    friendMessage.get().getMessages().add(new Message(message, sendTime));
                } else {
                    List<Message> messageList = new ArrayList<>();
                    messageList.add(new Message(message, sendTime));
                    messages.add(new FriendMessage(senderId, senderUsername, messageList));
                }
            }
            return messages;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<FriendResponse> getFriends(Integer userId) {
        ArrayList<FriendResponse> users = new ArrayList<>();
        try {
            ResultSet resultSet = statement.executeQuery(QueryGenerator.fetchFriends(userId));
            while (resultSet.next()) {
                users.add(new FriendResponse(resultSet.getInt("id"), resultSet.getString("username")));
            }
            return users;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean sendMessage(int senderId, int recipientId, String message) {
        try {
            int i = statement.executeUpdate(QueryGenerator.addMessage(senderId, recipientId, message));
            return i > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean saveQuizAttempt(int userId, Quiz q) {
        try {
            int i = statement.executeUpdate(QueryGenerator.saveQuizAttempt(userId, q.id, q.getScore(), q.getQuizTimeTaken()));
            return i > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Quiz> getCreatedQuizzes(int id) {
        List<Quiz> quizzes = new ArrayList<>();
        try {
            ResultSet resultSet = statement.executeQuery(QueryGenerator.fetchCreatedQuizzes(id));
            while (resultSet.next()) {
                Quiz quiz = getQuizObject(resultSet);
                quizzes.add(quiz);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return quizzes;
    }

    public List<Quiz> getTopTwoPopularQuizzes() {
        List<Quiz> quizzes = new ArrayList<>();
        try {
            ResultSet resultSet = statement.executeQuery(QueryGenerator.fetchTopThreePopularQuizzes());
            while (resultSet.next()) {
                Quiz quiz = getQuizObject(resultSet);
                quizzes.add(quiz);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return quizzes;
    }

    public  List<QuizAttempt> fetchPastResults(int userId, int quizId) {
        List<QuizAttempt> quizAttempts = new ArrayList<>();
        try {
            ResultSet resultSet = statement.executeQuery(QueryGenerator.fetchPastResults(userId, quizId));
            while(resultSet.next()) {
                int score = resultSet.getInt("score");
                String attemptTime = Utils.formatTimestamp(resultSet.getTimestamp("attemptTime"));
                int timeTaken = resultSet.getInt("timeTaken");
                quizAttempts.add(new QuizAttempt(score, timeTaken, attemptTime));
            }
            return quizAttempts;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void saveQuiz(Quiz quiz) {
        String displayType = quiz.displayType == Quiz.DisplayType.OnePage ? "one_page" : "multiple_page";
        try {
            statement.executeQuery(QueryGenerator.createQuiz(quiz.userId, quiz.title, quiz.description, quiz.randomize, displayType, quiz.immediateCorrection));
            for(Question question : quiz.getQuestions()) {
                statement.executeQuery(QueryGenerator.createQuestion(quiz.id, questionTypeToString(question.questionType), question.questionText));
                if(question.questionType == Question.QuestionType.MATCHING){
                    for(MatchingAnswer matchingAnswer : question.getMatchingAnswers()){
                        statement.executeQuery(QueryGenerator.createMatchingAnswer(question.id, matchingAnswer.leftMatch, matchingAnswer.rightMatch));
                    }
                }else{
                    for(Answer answer : question.getAnswers()) {
                        statement.executeQuery(QueryGenerator.createAnswer(question.id, answer.toString(), answer.isCorrect, answer.order));
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private String questionTypeToString(Question.QuestionType type) {
        if(type == Question.QuestionType.QUESTION_RESPONSE){
            return "question_response";
        }else if(type == Question.QuestionType.FILL_IN_BLANK){
            return "fill_in_blank";
        }
        else if(type == Question.QuestionType.MULTI_CHOICE){
            return "multi_choice";
        }
        else if(type == Question.QuestionType.PICTURE_RESPONSE){
            return "picture_response";
        }
        else if(type == Question.QuestionType.MULTI_ANSWER){
            return "multi_answer";
        }
        else if(type == Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER){
            return "multi_choice_multi_answer";
        }
        else if(type == Question.QuestionType.MATCHING){
            return "matching";
        }
        return "question_response";
    }
}
