package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.quizzes.Answer;
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
        int id = Integer.parseInt(req.getParameter("questionId"));
        Question question = currentQuiz.getQuestion(id);
        if(question.questionType == Question.QuestionType.MATCHING) {
            ArrayList<String> leftMatches = new ArrayList<>();
            ArrayList<String> rightMatches = new ArrayList<>();
            for (int i = 0; i < question.getMatchingAnswers().size(); i++) {
                leftMatches.add(question.getMatchingAnswers().get(i).leftMatch);
                rightMatches.add(req.getParameter("rightMatch" + i));
            }
            question.submitMatches(leftMatches, rightMatches);
        }else if(question.questionType == Question.QuestionType.MULTI_ANSWER){
            int numberOfAnswers = question.getAnswers().size();
            ArrayList<String> selectedAnswers = new ArrayList<String>();
            for(int i = 0; i < numberOfAnswers; i++){
                String selectedAnswer = req.getParameter("answer" + i);
                selectedAnswers.add(selectedAnswer);
            }
            question.submitMultipleAnswers(selectedAnswers);
        }else if (question.questionType == Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER) {
            String[] selectedAnswers = req.getParameterValues("selectedAnswers");
            if (selectedAnswers != null) {
                ArrayList<String> selectedAnswersList = new ArrayList<>(Arrays.asList(selectedAnswers));
                question.submitMultipleAnswers(selectedAnswersList);
            }
        } else if (question.questionType == Question.QuestionType.MULTI_CHOICE) {
            String selectedAnswer = req.getParameter("selectedAnswer");
            question.submitAnswer(selectedAnswer);
        }
        else{
            question.submitAnswer(req.getParameter("answer"));
        }

        System.out.printf(""+question.getScore());
    }
}
