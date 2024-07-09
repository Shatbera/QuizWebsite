package models.quizzes;

import junit.framework.TestCase;

import java.util.ArrayList;


public class QuizTest extends TestCase {
    private Quiz quiz;
    private ArrayList<Question> questions;


    @Override
    protected void setUp() throws Exception {
        quiz = new Quiz(1, 1, "Sample Quiz", "This is a sample quiz", false, Quiz.DisplayType.MultiplePage, true);

        questions = new ArrayList<>();
        Question question1 = new Question(1, Question.QuestionType.MULTI_CHOICE, "What is 2 + 2?");
        ArrayList<Answer> answers1 = new ArrayList<>();
        answers1.add(new Answer("4", true));
        answers1.add(new Answer("3", false));
        answers1.add(new Answer("2", false));
        question1.setAnswers(answers1);

        Question question2 = new Question(2, Question.QuestionType.MULTI_CHOICE, "What is the capital of France?");
        ArrayList<Answer> answers2 = new ArrayList<>();
        answers2.add(new Answer("Paris", true));
        answers2.add(new Answer("London", false));
        answers2.add(new Answer("Berlin", false));
        question2.setAnswers(answers2);

        questions.add(question1);
        questions.add(question2);

        quiz.setQuestions(questions);
    }

    public void testGetQuestion(){
        assertEquals("What is 2 + 2?", quiz.getQuestion(1).questionText);
    }

    public void testStartQuiz() {
        quiz.startQuiz();
        assertNotNull(quiz.getQuestions());
        assertFalse(quiz.getQuestions().isEmpty());
    }


    public void testEndQuiz() {
        quiz.startQuiz();
        quiz.endQuiz();
        assertTrue(quiz.isQuizEnded());
    }


    public void testGetScore() {
        quiz.startQuiz();
        questions.get(0).submitAnswer("4");
        questions.get(1).submitAnswer("Paris");
        assertEquals(2, quiz.getScore());
    }


    public void testGetMaxScore() {
        assertEquals(2, quiz.getMaxScore());
    }


    public void testGetScorePercentage() {
        quiz.startQuiz();
        questions.get(0).submitAnswer("4");
        questions.get(1).submitAnswer("Paris");
        assertEquals(100, quiz.getScorePercentage());
    }


    public void testGetNextQuestion() {
        quiz.startQuiz();
        assertEquals(questions.get(0), quiz.getNextQuestion());
        questions.get(0).submitAnswer("4");
        assertEquals(questions.get(1), quiz.getNextQuestion());
        questions.get(1).submitAnswer("Paris");
        assertNull(quiz.getNextQuestion());
    }


    public void testQuizInitialization() {
        assertEquals(1, quiz.id);
        assertEquals(1, quiz.userId);
        assertEquals("Sample Quiz", quiz.title);
        assertEquals("This is a sample quiz", quiz.description);
        assertFalse(quiz.randomize);
        assertEquals(Quiz.DisplayType.MultiplePage, quiz.displayType);
        assertTrue(quiz.immediateCorrection);
    }
}
