package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.quizzes.Question;
import models.quizzes.Quiz;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

@WebServlet("/SubmitAnswerServlet")
public class SubmitAnswerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Quiz currentQuiz = (Quiz) session.getAttribute("currentQuiz");

        String[] questionIds = req.getParameterValues("questionId");
        for(String questionId : questionIds) {
            int id = Integer.parseInt(questionId);
            Question question = currentQuiz.getQuestion(id);

            handleSingleAnswerQuestion(req, resp, question);
            handleMultiAnswerQuestion(req, resp, question);
            handleMatchingQuestion(req, resp, question);
            handleMultiChoiceQuestion(req, resp, question);
            handleMultiChoiceMultiAnswerQuestion(req, resp, question);
        }
    }

    private void handleSingleAnswerQuestion(HttpServletRequest req, HttpServletResponse resp, Question question) throws ServletException, IOException {
        if(question.questionType != Question.QuestionType.QUESTION_RESPONSE &&
                question.questionType != Question.QuestionType.FILL_IN_BLANK &&
                question.questionType != Question.QuestionType.PICTURE_RESPONSE)
            return;
        question.submitAnswer(req.getParameter("answer_"+question.id));
    }

    private void handleMultiAnswerQuestion(HttpServletRequest req, HttpServletResponse resp, Question question) throws ServletException, IOException {
        if(question.questionType != Question.QuestionType.MATCHING)
            return;
        ArrayList<String> leftMatches = new ArrayList<>();
        ArrayList<String> rightMatches = new ArrayList<>();
        for (int i = 0; i < question.getMatchingAnswers().size(); i++) {
            leftMatches.add(question.getMatchingAnswers().get(i).leftMatch);
            rightMatches.add(req.getParameter("rightMatch_"+question.id+"_" + i));
        }
        question.submitMatches(leftMatches, rightMatches);
    }

    private void handleMatchingQuestion(HttpServletRequest req, HttpServletResponse resp, Question question) throws ServletException, IOException {
        if(question.questionType != Question.QuestionType.MULTI_ANSWER)
            return;
        int numberOfAnswers = question.getAnswers().size();
        ArrayList<String> selectedAnswers = new ArrayList<String>();
        for(int i = 0; i < numberOfAnswers; i++){
            String selectedAnswer = req.getParameter("answer_"+question.id+"_" + i);
            selectedAnswers.add(selectedAnswer);
        }
        question.submitMultipleAnswers(selectedAnswers);
    }

    private void handleMultiChoiceQuestion(HttpServletRequest req, HttpServletResponse resp, Question question) throws ServletException, IOException {
        if(question.questionType != Question.QuestionType.MULTI_CHOICE)
            return;
        String selectedAnswer = req.getParameter("selectedAnswer_"+question.id);
        question.submitAnswer(selectedAnswer);
    }

    private void handleMultiChoiceMultiAnswerQuestion(HttpServletRequest req, HttpServletResponse resp, Question question) throws ServletException, IOException {
        if(question.questionType != Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER)
            return;
        String[] selectedAnswers = req.getParameterValues("selectedAnswers_"+question.id);
        if (selectedAnswers != null) {
            ArrayList<String> selectedAnswersList = new ArrayList<>(Arrays.asList(selectedAnswers));
            question.submitMultipleAnswers(selectedAnswersList);
        }
    }
}
