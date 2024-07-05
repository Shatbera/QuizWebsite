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

@WebServlet("/SubmitAnswerServlet")
public class SubmitAnswerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Quiz currentQuiz = (Quiz) session.getAttribute("currentQuiz");
        int id = Integer.parseInt(req.getParameter("questionId"));
        Question question = currentQuiz.getQuestion(id);
        if(question.questionType == Question.QuestionType.MATCHING) {

        }else if(question.questionType == Question.QuestionType.MULTI_ANSWER || question.questionType == Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER){

        }else{
            question.submitAnswer(req.getParameter("answer"));
        }
    }
}
