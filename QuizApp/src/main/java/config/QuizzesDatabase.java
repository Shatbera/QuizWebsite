package config;

import Models.quizzes.Answer;
import Models.quizzes.MatchingAnswer;
import Models.quizzes.Question;
import Models.quizzes.Quiz;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class QuizzesDatabase {

    private static final String database = "mydatabase";

    private Statement statement;

    public QuizzesDatabase(){
        try {
            Connection connection = DatabaseConfig.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            statement.execute("USE " + database);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Quiz> getAllQuizzes(){
        ArrayList<Quiz> quizzes = new ArrayList<>();
        try {
            ResultSet rs = statement.executeQuery(QueryGenerator.getAllQuizzes());
            while(rs.next()){
                Quiz quiz = getQuizObject(rs);
                quizzes.add(quiz);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return quizzes;
    }


    public ArrayList<Question> getQuizQuestions(int quizId){
        ArrayList<Question> questions = new ArrayList<>();

        try {
            ResultSet rs = statement.executeQuery(QueryGenerator.getQuizQuestions(quizId));
            while(rs.next()){
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

    private Question.QuestionType getQuestionType(String type){
        switch (type){
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

    public ArrayList<Answer> getAnswers(int questionId){
        ArrayList<Answer> answers = new ArrayList<>();
        try {
            ResultSet rs = statement.executeQuery(QueryGenerator.getAnswers(questionId));
            while(rs.next()){
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

    public ArrayList<MatchingAnswer> getMatchingAnswers(int questionId){
        ArrayList<MatchingAnswer> answers = new ArrayList<>();
        try {
            ResultSet rs = statement.executeQuery(QueryGenerator.getMatchingAnswers(questionId));
            while(rs.next()){
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




}
