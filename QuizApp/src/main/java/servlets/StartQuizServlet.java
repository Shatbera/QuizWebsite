package servlets;

import config.DatabaseManager;
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

@WebServlet("/StartQuizServlet")
public class StartQuizServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String quizIdStr = req.getParameter("quizId");
        int quizId = Integer.parseInt(quizIdStr);
        DatabaseManager db = (DatabaseManager) getServletContext().getAttribute(DatabaseManager.NAME);
        Quiz quiz = db.getQuiz(quizId);
        ArrayList<Question> questions = db.getQuizQuestions(quizId);
        /*for(Question question : questions) {
            if(question.questionType == Question.QuestionType.MATCHING){
                ArrayList<MatchingAnswer> answers = db.getMatchingAnswers(question.id);
                question.setAnswers(answers.toArray());
            }else{
                ArrayList<Answer> answers = db.getAnswers(question.id);
                question.setAnswers(answers.toArray());
            }
        }*/
        quiz.setQuestions(questions);
        HttpSession session = req.getSession();
        session.setAttribute("currentQuiz", quiz);
        req.getRequestDispatcher("singlePageQuestions.jsp").forward(req, resp);
    }
}
