package tests;

import Models.Quiz;
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

    public void testGetAllQuizzes(){
        ArrayList<Quiz> quizzes = quizzesDatabase.getAllQuizzes();
        assertEquals(10, quizzes.size());

    }
}
