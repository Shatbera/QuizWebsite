package tests;

import Models.quizzes.Answer;
import Models.quizzes.MatchingAnswer;
import Models.quizzes.Question;
import Models.quizzes.Quiz;
import config.QuizzesDatabase;
import junit.framework.TestCase;

import java.util.ArrayList;

public class QuizzesDatabaseTest extends TestCase {

    private QuizzesDatabase quizzesDatabase;

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        quizzesDatabase = new QuizzesDatabase();
    }

    public void testAllQuizzes(){
        ArrayList<Quiz> quizzes = quizzesDatabase.getAllQuizzes();
        for(Quiz quiz : quizzes){
            System.out.println("quiz " + quiz.id + " " + quiz.title);
            testQuiz(quiz);
        }
    }

    private void testQuiz(Quiz quiz){
        ArrayList<Question> questions = quizzesDatabase.getQuizQuestions(quiz.id);
        for(Question question : questions){
            System.out.println("    question " + question.id + " " + question.questionText);
            testQuestion(question);
        }
    }

    private void testQuestion(Question question){
        if(question.questionType == Question.QuestionType.MATCHING){
            ArrayList<MatchingAnswer> answers = quizzesDatabase.getMatchingAnswers(question.id);
            for(MatchingAnswer answer : answers){
                System.out.println("        " + answer.id + ". " + answer.leftMatch + " --- " + answer.rightMatch);
            }
        }else{
            ArrayList<Answer> answers = quizzesDatabase.getAnswers(question.id);
            for(Answer answer : answers){
                System.out.println("        " + answer.id + ". " + answer + "   " + "("+answer.isCorrect+")");
            }
        }
    }
}
