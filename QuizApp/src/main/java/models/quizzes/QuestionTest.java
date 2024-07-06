package models.quizzes;

import junit.framework.TestCase;

import java.util.ArrayList;

public class QuestionTest extends TestCase {

    public void testQuestionResponse() {
        Question question = new Question(1, Question.QuestionType.QUESTION_RESPONSE, "What is the capital of France?");
        ArrayList<Answer> answers = new ArrayList<>();
        answers.add(new Answer(1, "Paris", true, 0));
        answers.add(new Answer(2, "London", false, 0));
        answers.add(new Answer(3, "Berlin", false, 0));
        question.setAnswers(answers);

        assertEquals(1, question.submitAnswer("Paris"));
        assertEquals(1, question.getScore());
        assertEquals(0, question.submitAnswer("London"));
        assertEquals(0, question.getScore());
        assertEquals(1, question.getMaxScore());
    }

    public void testMultiAnswer() {
        Question question = new Question(2, Question.QuestionType.MULTI_ANSWER, "Select the prime numbers");
        ArrayList<Answer> answers = new ArrayList<>();
        answers.add(new Answer(1, "2", true, 0));
        answers.add(new Answer(2, "3", true, 0));
        answers.add(new Answer(3, "4", true, 0));
        answers.add(new Answer(4, "5", true, 0));
        question.setAnswers(answers);

        ArrayList<String> selectedAnswers = new ArrayList<>();
        selectedAnswers.add("2");
        selectedAnswers.add("3");
        selectedAnswers.add("5");

        assertEquals(3, question.submitMultipleAnswers(selectedAnswers));

        selectedAnswers.clear();
        selectedAnswers.add("2");
        selectedAnswers.add("11");

        assertEquals(1, question.submitMultipleAnswers(selectedAnswers));
    }

    public void testMultiChoiceMultiAnswer() {
        Question question = new Question(3, Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER, "Select the colors of the rainbow");
        ArrayList<Answer> answers = new ArrayList<>();
        answers.add(new Answer(1, "Red", true, 0));
        answers.add(new Answer(2, "Green", true, 0));
        answers.add(new Answer(3, "Blue", true, 0));
        answers.add(new Answer(4, "Black", false, 0));
        question.setAnswers(answers);

        ArrayList<String> selectedAnswers = new ArrayList<>();
        selectedAnswers.add("Red");
        selectedAnswers.add("Green");
        selectedAnswers.add("Blue");

        assertEquals(1, question.submitMultipleAnswers(selectedAnswers));

        selectedAnswers.add("Black");
        assertEquals(0, question.submitMultipleAnswers(selectedAnswers));
    }

    public void testMatching() {
        Question question = new Question(4, Question.QuestionType.MATCHING, "Match the countries to their capitals");
        ArrayList<MatchingAnswer> matchingAnswers = new ArrayList<>();
        matchingAnswers.add(new MatchingAnswer(1, "France", "Paris"));
        matchingAnswers.add(new MatchingAnswer(2, "Germany", "Berlin"));
        matchingAnswers.add(new MatchingAnswer(3, "Italy", "Rome"));
        question.setMatchingAnswers(matchingAnswers);

        ArrayList<String> leftMatches = new ArrayList<>();
        leftMatches.add("France");
        leftMatches.add("Germany");
        leftMatches.add("Italy");

        ArrayList<String> rightMatches = new ArrayList<>();
        rightMatches.add("Paris");
        rightMatches.add("Berlin");
        rightMatches.add("Rome");

        assertEquals(1, question.submitMatches(leftMatches, rightMatches));

        rightMatches.set(2, "Milan");
        assertEquals(0, question.submitMatches(leftMatches, rightMatches));
    }
}
