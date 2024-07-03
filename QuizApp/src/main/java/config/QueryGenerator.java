package config;

public class QueryGenerator {
    public static String getAllQuizzes(){
        return "SELECT * FROM quizzes";
    }

    public static String getQuizQuestions(int quizId){
        return String.format("SELECT * FROM questions WHERE quiz_id = %s;", quizId);
    }

    public static String getAnswers(int questionId){
        return String.format("SELECT * FROM answers WHERE question_id = %s;", questionId);
    }

    public static String getMatchingAnswers(int questionId){
        return String.format("SELECT * FROM matches WHERE question_id = %s;", questionId);
    }
}
